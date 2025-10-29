def create
  # Associate the new transaction with the currently logged-in user
  @transaction = current_user.transactions.new(transaction_params)

  respond_to do |format|
    if @transaction.save
      format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
      format.json { render :show, status: :created, location: @transaction }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @transaction.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /transactions/1 or /transactions/1.json
def update
  respond_to do |format|
    if @transaction.update(transaction_params)
      format.html { redirect_to @transaction, notice: "Transaction was successfully updated.", status: :see_other }
      format.json { render :show, status: :ok, location: @transaction }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @transaction.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /transactions/1 or /transactions/1.json
def destroy
  @transaction.destroy!

  respond_to do |format|
    format.html { redirect_to transactions_path, notice: "Transaction was successfully destroyed.", status: :see_other }
    format.json { head :no_content }
  end
end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])  # Corrected this line
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:occurred_on, :amount, :note, :category_id)  # Fixed `expect` to `permit`
  end
