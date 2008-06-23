class OutlinePointsController < ApplicationController
  
  # return all OutlinePoints
  def find_all
    respond_to do |format|
      format.amf  { render :amf => OutlinePoint.find(:all) }
    end
  end
  
  # return a single OutlinePoint by id
  # expects id in params[0]
  def find_by_id
    respond_to do |format|
      format.amf { render :amf => OutlinePoint.find(params[0]) }
    end
  end

  # saves new or updates existing OutlinePoint
  # expect params[0] to be incoming OutlinePoint
  def save
    respond_to do |format|
      format.amf do
        @outline_point = params[0]

        if @outline_point.save
          render :amf => @outline_point
        else
          render :amf => FaultObject.new(@outline_point.errors.full_messages.join('\n'))
        end
      end
    end
  end

  # destroy a OutlinePoint
  # expects id in params[0]
  def destroy
    respond_to do |format|
      format.amf do
        @outline_point = OutlinePoint.find(params[0])
        @outline_point.destroy

        render :amf => true
      end
    end
  end

end
