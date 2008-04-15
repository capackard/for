class ContactsController < ApplicationController

  # return all Contacts
  def find_all
    render :amf => Contact.find(:all)
  end
  
  # return a single Contact, by id
  # expect single argument: contact id
  def find_by_id
    render :amf => Contact.find(params[:id])
  end

  # saves new or updates existing Contacts
  # expect params[0] to be incoming Contact
  def save
    @contact = params[0]

    if @contact.save
      render :amf => @contact
    else
      render :amf => FaultObject.new(@contact.errors.full_messages.join('\n'))
    end
  end

  # destroy a Contact
  # expect single argument: product id
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    render :amf => true
  end
end
