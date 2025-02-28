@isTest
public with sharing class LeadTriggerHandlerTest {

    @isTest
    static void leadTriggerHandler_handleTitleNormalization_titleUpdate() {
        List<Lead> leads = new List<Lead>();
        Lead lead = new Lead(FirstName = 'Tara', LastName = 'Fullerton', Company = 'Test', Title = 'vp');

        leads.add(lead);
        leads.add(new Lead(FirstName = 'Bob', LastName = 'Dole', Company = 'Test', Title = 'v.p.'));
        leads.add(new Lead(FirstName = 'James', LastName = 'Putty', Company = 'Test', Title = 'vice president'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'mgr'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'manage'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'head of department'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'exec'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'head'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'chief'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'assist'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'deputy'));
        leads.add(new Lead(FirstName = 'Dan', LastName = 'Smith', Company = 'Test', Title = 'jr'));

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(leads);
        Test.stopTest();

        Lead updatedLead = leads[0];

        Assert.areEqual('Vice President', updatedLead.Title, 'title should be Vice President');
        Assert.areEqual('Vice President', leads[1].Title, 'title should be Vice President');
        Assert.areEqual('Vice President', leads[2].Title, 'title should be Vice President');
        Assert.areEqual('Manager', leads[3].Title, 'title should be Manager');
        Assert.areEqual('Manager', leads[4].Title, 'title should be Manager');
        Assert.areEqual('Manager', leads[5].Title, 'title should be Manager');
        Assert.areEqual('Executive', leads[6].Title, 'title should be Executive');
        Assert.areEqual('Executive', leads[7].Title, 'title should be Executive');
        Assert.areEqual('Executive', leads[8].Title, 'title should be Executive');
        Assert.areEqual('Assistant', leads[9].Title, 'title should be Assistant');
        Assert.areEqual('Assistant', leads[10].Title, 'title should be Assistant');
        Assert.areEqual('Assistant', leads[11].Title, 'title should be Assistant');
       


    }

    @isTest
    static void leadTriggerHandler_handleAutoLeadScoring_updateAutoScore() {

        List<Lead> leads = new List<Lead>();
        Lead lead = new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'web', Phone = '5199936165', Email = 'tfu@hotmail.com', Industry = 'Technology');

        leads.add(lead);
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'email', Phone = '5199936165', Email = 'tfu@hotmail.com', Industry = 'Technology'));
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'web', Phone = null, Email = 'tfu@hotmail.com', Industry = 'Technology'));
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'web', Phone = '5199936165', Email = null, Industry = 'Technology'));
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'web', Phone = '5199936165', Email = 'tfu@hotmail.com', Industry = 'Electronics'));
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'phone', Phone = null, Email = null, Industry = 'Technology'));
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'web', Phone = null, Email = 'tfu@hotmail.com', Industry = 'Mechanical'));
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'phone', Phone = '5199936165', Email = 'tfu@hotmail.com', Industry = 'Nursing'));
        leads.add(new Lead(FirstName = 'Test', LastName = 'Test', Company = 'Test', LeadSource = 'web', Phone = '5199936165', Email = 'tfu@hotmail.com', Industry = 'Technology', Lead_Score__c = 20));

        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(leads);
        Test.stopTest();

        Lead updatedLead = leads[0];

        Assert.areEqual(18, updatedLead.Lead_Score__c, 'Lead Score should be 18');
        Assert.areEqual(15, leads[1].Lead_Score__c, 'Lead Score should be 15');
        Assert.areEqual(13, leads[2].Lead_Score__c, 'Lead Score should be 13');
        Assert.areEqual(15, leads[3].Lead_Score__c, 'Lead Score should be 15');
        Assert.areEqual(8, leads[4].Lead_Score__c, 'Lead Score should be 8');
        Assert.areEqual(10, leads[5].Lead_Score__c, 'Lead Score should be 10');
        Assert.areEqual(3, leads[6].Lead_Score__c, 'Lead Score should be 3');
        Assert.areEqual(5, leads[7].Lead_Score__c, 'Lead Score should be 5');
        Assert.areEqual(18, leads[8].Lead_Score__c, 'Lead Score should be 18');
    }

    @isTest
    static void leadTriggerHandler_handleLeadAutoConvert_convertLead() {
        Account acc = DataTestFactory.createAccount('Test Account');
        insert acc;
        DataTestFactory.createContact(acc.Id, 'test@test.com');
        List<Lead> leads = DataTestFactory.createLeads(201, 'test@test.com', false);
        
        Test.startTest();
        insert leads;
        Test.stopTest();

        List<Lead> updatedLeads = [SELECT Id, IsConverted FROM Lead WHERE Id IN :leads];
        Assert.isTrue(updatedLeads.size()>0, 'Lead should be updated');
        system.debug(updatedLeads.size());
            for (Lead lead : updatedLeads){
            Assert.isTrue(lead.IsConverted, 'Lead should be converted');
}
}
}
