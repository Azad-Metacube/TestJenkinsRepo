public class ConvertToJSONString {

    public String jsonString { get; set; }

    public Integer ContactNumber { get; set; }

    public String EmailID { get; set; }

    public Date DOB { get; set; }

    public String LastName { get; set; }

    public String FirstName { get; set; }

    public PageReference getJSONString() {
        System.JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
        generator.writeStringField('First Name', FirstName );
        generator.writeStringField('Last Name', LastName );
        generator.writeDateTimeField('Date of Birth',DOB);
        generator.writeStringField('Email Id', EmailID );
        generator.writeNumberField('Phone', ContactNumber);
        generator.writeEndObject();
        jsonString = generator.getAsString();
        return null;
    }

    public PageReference reset() {
        FirstName = null;
        LastName = null;
        DOB = null;
        EmailID = null;
        ContactNumber = null;
        jsonString = null;
        return null;
    }



}