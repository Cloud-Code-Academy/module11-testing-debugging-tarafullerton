public with sharing class DataTestFactory {
    public static Account createAccount(String name){
        Account acc = new Account();
        acc.Name = name;
        acc.Industry = 'Technology';
        acc.Type = 'Customer - Direct';
        
        return acc;
    }

    public static Contact createContact(Id accountId, String email){
        Contact contact = new Contact();
        contact.AccountId = accountId;
        contact.Email = email;
        contact.FirstName = 'Test';
        contact.LastName = 'Test';

        insert contact;
        return contact;
    }
    public static Lead createLead(String email){
        Lead lead = new Lead();
        lead.FirstName = 'Test';
        lead.LastName = 'Lead';
        lead.Email = email;
        lead.Company = 'Test Company';
       
        return lead;
    }

    public static List<Lead> createLeads(Integer numberOfLeads, String email, Boolean doInsert) {
        List<Lead> leads = new List<Lead>();
        
        for (Integer i = 0; i < numberOfLeads; i++ ){
        Lead lead = createLead(email);
        leads.add(lead);   
        }
        if (doInsert){
            insert leads;
        }
        return leads;      

    }
}