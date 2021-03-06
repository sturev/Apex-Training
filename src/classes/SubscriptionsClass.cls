public class SubscriptionsClass { 
	//--------------------------------------------------------------------------------------------
	// For each jobApp, create a chatter subscription for the hiring manager of the associated position
	// jobApps - the job applications to which the hiring managers should be subscribed.
	//--------------------------------------------------------------------------------------------
	public static void HiringManagerSubscribeNewPosition(List <Position__c> positions) {
		System.Debug('HiringManagerSubscribeNewPosition: Entering');
		//TODO: Create a list of EntitySubscription objects called subscriptions and initialize it to an empty list.
		//TODO: Loop through positions and: 
		//TODO:    		Create an EntitySubscription object
		//TODO:         Set the ParentId of the EntitySubscription to the id of the current position 
		//TODO:    		Set the SubscriberId of the EntitySubscription to the id of the hiring manager associated with the position.
		//TODO:         Add the EntitySubscription object to the subscriptions list.
		List <EntitySubscription> subscriptions = new List <EntitySubscription>();
		for (Position__c pos :positions) {
			EntitySubscription eSubs = new EntitySubscription(parentid = pos.id, subscriberid = pos.Hiring_Manager__c);
			subscriptions.add(eSubs);
		}
		try {
			Database.insert(subscriptions);
		}
		catch (DMLException dmlEx) {
			//if we get an error because this user is already following this object, it's okay.
			if (dmlEx.getDmlType(0) == statusCode.DUPLICATE_VALUE) {
				System.Debug('HiringManagerSubscribeNewPosition: subscription already exists');
			} else {
				//otherwise we have a more serious error that we need to throw.
				throw dmlEx;
			}
		}
	}
}