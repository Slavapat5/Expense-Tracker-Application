class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  def index
  @categories = current_user.categories
  @transactions = current_user.transactions.includes(:category)

  # Filter by category
  if params[:category_id].present?
    @transactions = @transactions.where(category_id: params[:category_id])
  end

  # Date range filter (fix to occurred_on)
  if params[:start_date].present?
    @transactions = @transactions.where("occurred_on >= ?", params[:start_date])
  end

  if params[:end_date].present?
    @transactions = @transactions.where("occurred_on <= ?", params[:end_date])
  end

  # Sorting (fix column name)
  case params[:sort]
  when "amount_asc"
    @transactions = @transactions.order(amount: :asc)
  when "amount_desc"
    @transactions = @transactions.order(amount: :desc)
  when "oldest"
    @transactions = @transactions.order(occurred_on: :asc)
  else
    @transactions = @transactions.order(occurred_on: :desc) # default newest first
  end
end



  # GET /transactions/1
  def show
  end

  # GET /transactions/new
  def new
    @transaction = current_user.transactions.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = current_user.transactions.new(transaction_params)

    if @transaction.save
      redirect_to @transaction, notice: "Transaction was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: "Transaction updated."
    else
      render :edit
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    redirect_to transactions_path, notice: "Transaction deleted."
  end

  private

    # Only load transactions belonging to current_user
    def set_transaction
      @transaction = current_user.transactions.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to transactions_path, alert: "Not authorized to view that transaction."
    end

    def transaction_params
      params.require(:transaction).permit(:occurred_on, :amount, :note, :category_id, :transaction_type)
    end
end

