@RestResource(urlMapping='/integration-service/*')
global with sharing class CustomRestEndpointRecipes {
    @HttpDelete
    global static void deleteSingleContact() {
        // Get the Contact Id from the URL (no validation)
        String contactId = RestContext.request.requestURI.substringAfterLast('/');
        // Query for the Contact (no try/catch, no permission checks)
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Id = :contactId];
        // Delete the Contact if found, else do nothing special
        if (contacts.size() > 0) {
            delete contacts[0];
            // Set response (no JSON, no error structure)
            RestContext.response.statusCode = 200;
            RestContext.response.responseBody = Blob.valueOf('Contact deleted');
        } else {
            RestContext.response.statusCode = 404;
            RestContext.response.responseBody = Blob.valueOf('Contact not found');
        }
    }
}

