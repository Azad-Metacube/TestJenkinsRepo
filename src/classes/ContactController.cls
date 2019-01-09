public class ContactController {
@AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> contacts = 
                [SELECT Id, Name, MailingStreet, Phone, Email,Level__c FROM Contact];
        return contacts;
    }
    
    @AuraEnabled
    // Retrieve all primary contacts
    public static List<Contact> getPrimary() {
        List<Contact> primaryContacts = 
             [SELECT Id, Name, MailingStreet, Phone, Email,Level__c FROM Contact WHERE kaerx__Level__c = 'Primary'];
        return primaryContacts;
    }
}