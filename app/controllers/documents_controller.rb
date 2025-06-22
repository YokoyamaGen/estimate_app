class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :destroy]

  def index
    @documents = Document.all
    apply_filters
    @documents = @documents.order(sort_column + ' ' + sort_direction)
  end

  def modal_index
    @documents = Document.all
    apply_filters
    @documents = @documents.order(sort_column + ' ' + sort_direction)
    
    respond_to do |format|
      format.html { render :modal_index, layout: false }
      format.turbo_stream { render turbo_stream: turbo_stream.update("documents-list", partial: "documents/list", locals: { documents: @documents }) }
    end
  end

  def show
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    
    if @document.save
      redirect_to documents_path, notice: 'ドキュメントが作成されました。'
    else
      render :new
    end
  end

  def destroy
    @document.destroy
    redirect_to documents_path, notice: 'ドキュメントが削除されました。'
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :amount, :client, :project, :transaction_date, :pdf_file)
  end

  def apply_filters
    if params[:search].present?
      @documents = @documents.where("name LIKE ?", "%#{params[:search]}%")
    end
  end

  def sort_column
    %w[name amount client project transaction_date].include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
