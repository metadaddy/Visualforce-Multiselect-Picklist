/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class MultiselectExampleControllerTest {
    static testMethod void testMultiselectExampleController() {
    	// Create some test data
    	List<Contact> l = new List<Contact>();
    	for (Integer i = 0; i < 10; i++) {
    		Contact c = new Contact(firstName = 'User'+i, lastName = 'Name'+i);
            l.add(c);
    	}
    	insert l;
    	
    	MultiselectExampleController c = new MultiselectExampleController();
    	
    	List<Contact> contacts = [SELECT Name, Id FROM Contact];
    	
    	System.assertEquals(c.selectedContacts.size(), 0);
        System.assertEquals(c.allContacts.size(), contacts.size());
        
        c.save();
        
        System.assertEquals(c.message, 'Selected Contacts: ');

        c.selectedContacts.add(new SelectOption('123456789123456', 'Dummy User'));
        c.selectedContacts.add(new SelectOption('234567891234567', 'Example User'));
        
        c.save();
        
        System.assertEquals(c.message, 
                'Selected Contacts: Dummy User (123456789123456), Example User (234567891234567)');
    }
}