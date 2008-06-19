class NotesController < ApplicationController
  
  # return all Notes
  def find_all
    respond_to do |format|
      format.amf  { render :amf => Note.find(:all) }
    end
  end
  
  # return a single Note by id
  # expects id in params[0]
  def find_by_id
    respond_to do |format|
      format.amf { render :amf => Note.find(params[0]) }
    end
  end

  # saves new or updates existing Note
  # expect params[0] to be incoming Note
  def save
    respond_to do |format|
      format.amf do
        @note = params[0]

        if @note.save
          render :amf => @note
        else
          render :amf => FaultObject.new(@note.errors.full_messages.join('\n'))
        end
      end
    end
  end

  # destroy a Note
  # expects id in params[0]
  def destroy
    respond_to do |format|
      format.amf do
        @note = Note.find(params[0])
        @note.destroy

        render :amf => true
      end
    end
  end

end
