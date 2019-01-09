global class ProcessXML implements Messaging.InboundEmailHandler {

    public List<Contact> listOfContactRecords = new List<Contact>();
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.Inboundenvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        try{
	        Messaging.InboundEmail.TextAttachment[] myTextAttachments = email.textAttachments;
	        if(myTextAttachments !=null){
	            for(Messaging.InboundEmail.TextAttachment singleAttachment: myTextAttachments ){
	                if(singleAttachment.filename.endsWith('.xml')){
	                    XmlStreamReader reader= new XmlStreamReader(singleAttachment.body);
	                    while(reader.hasNext()) {
	                        if (reader.getEventType() == XmlTag.START_ELEMENT){
	                            if ('Contact' == reader.getLocalName()){
	                                Contact tempContact = getContact(reader);                  	
	                                    listOfContactRecords.add(tempContact);                 
	                            }
	                        }
	                        reader.next();
	                    }
	                } 
	            }
	        }
	        insert listOfContactRecords;
        }
        catch(Exception e){
        	// Return an email message to the user
            result.success = false;         
            result.message = 'An error occured processing your message. ' + e.getMessage();
        }
        return result;
    }
    
    Contact getContact(XmlStreamReader reader){
        Contact tempContact = new Contact();
        while(reader.hasNext()) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                break;
            } else if (reader.getEventType() == XmlTag.START_ELEMENT) {
                
                if('fname' == reader.getLocalName()){
                	tempContact.FirstName = getData(reader);
                }else if('lname' == reader.getLocalName()){
                	tempContact.LastName = getData(reader);
                }else if('emailId' == reader.getLocalName()){
                	tempContact.Email = getData(reader);
                }else if('mobile' == reader.getLocalName()){
                	tempContact.MobilePhone = getData(reader);
                }else if('title' == reader.getLocalName()){
                	tempContact.Title = getData(reader);
                }
            }
            reader.next();
        }    
        return tempContact;
    }   
    
    String getdata(XmlStreamReader reader){
    	String textData;	
    	while(reader.hasNext()){
        	if (reader.getEventType() == XmlTag.END_ELEMENT) {
            	break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS) {
            	textData = reader.getText();
            }
            reader.next();
        }
        return textData;
    } 
}