module Admin 
  class ChargesController < AdminController
   def index
    @pendentes = Charge.available_pending
    @efetivadas = Charge.available_approved
    @charges = Charge.all
    @recusadas = @charges.where.not(status: [:pending, :approved])
   end

   def show 
    @charge = Charge.find(params[:id])
    @receipt = Receipt.find_by(charge: @charge)
   end

   def pending 
    @pendentes = Charge.available_pending
   end

   def approved 
    @efetivadas = Charge.available_approved
   end

   def approve 
    @charge = Charge.find(params[:id])
    @charge.approved!
    LogCharge.create!(return_code: 5, attempt_date: Date.today, effective_date: Date.today, charge: @charge)
    Receipt.create(due_date:1.month.from_now, effective_date: Date.today, charge: @charge )
    redirect_to admin_charge_path(@charge)
   end
  end
end