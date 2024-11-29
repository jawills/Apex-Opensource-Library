# Constants
*How to store and reference constants*

---
# Documentation
Each organization should have a Constant class to store picklist values and other constants. When picklist change, we only have to change it in one place in
code rather than looking for all usages.  
This class can be constructed in two ways:

## Simple Approach
Each constant is just a static variable in Constants class.  
- Use BEM naming convention to name variables from most general concept to most detailed — SOBJECT_FIELD_VALUE. Example: ORDER_STATUS_COMPLETED  
- Field modifiers should be declared once or minimal number of times. Declaring them for each field obfuscates the code and counts against Apex character limit.

```apex
public with sharing class Constants {
	public final static String
		ACCOUNT_TYPE_CUSTOMER = 'Customer',
		ACCOUNT_TYPE_SMB = 'SMB',
		ACCOUNT_TYPE_ENTERPRISE = 'Enterprise',
		ACCOUNT_TYPE_PERSON = 'Person',

		ORDER_STATUS_NEW = 'New',
		ORDER_STATUS_INPROGRESS = 'In Progress',
		ORDER_STATUS_ON_HOLD = 'On Hold',
		ORDER_STATUS_COMPLETED = 'Completed';
}
```

```apex
String orderStatus = Constants.ORDER_STATUS_NEW;
```

##### Pros
- Trivial to use and expand
- Does not introduce a lot of noise

##### Cons
- Cannot create shorthands in client code. Each constant invocation will have full length (see shorthand in Wrappers approach).

## Wrappers Approach

Within Constants class, each sobject and each field should have a separate inner class:

```apex
public with sharing class Constants {
	public final AccountConstants ACCOUNT = new AccountConstants();
	public final OrderConstants ORDER = new OrderConstants();

	public class AccountConstants {
		public AccountType TYPE = new AccountType();
	}

	// Values of Account.Type picklist
	public class AccountType {
		public final String
			CUSTOMER = 'Customer',
			SMB = 'SMB',
			ENTERPRISE = 'ENTERPRISE',
			PERSON = 'Person';
	}
}
```

```apex
String orderStatus = Constants.ORDER.STATUS.NEW;
```

##### Pros
- Constants are easier to navigate for IDE, since we can use dot-notation to traverse objects   
  *(note that this argument is only partially-correct because if we type ORDER_ then IDE will only autocomplete variables that start with that)
- Constants are organized in classes.
- It's possible to create shorthands in client code. If we have to reference values of one picklist multiple times, we can do it with less code:
  ```apex
  //Old
  for (Order o : orders) {
	  if (o.Status == Constants.ORDER_STATUS_NEW || o.Status == Constants.ORDER_STATUS_IN_PROGRESS) {
		  //... do something
	  }
  }
  
  //Shorthand
  String STATUS = Constants.ORDER.STATUS;
  for (Order o : orders) {
	  if (o.Status == STATUS.NEW || o.Status == STATUS.IN_PROGRESS) {
		  //... do something
	  }
  }
  ```

##### Cons
- Constants class is obfuscated and bloats.
- Constants class initialization may be less performant (though this can be alleviated through lazy-evaluation).

## Lazily-Evaluated Constants
Use methods or get properties to lazily-evaluate constants for better performance — when Constants class is first referenced,
it will initialize all constants declared in `name = value` manner.
If there are hundreds of constants, this may account for an unnecessary slowdown of apex transaction. 

```apex
public class Constants {
	public String ACCOUNT_LABEL { get {return Schema.Account.SObjectType.getDescribe().getLabel();} }

	public String ORDER_LABEL() {
		return Schema.Order.SObjectType.getDescribe().getLabel();
	}
}
```

Lazily evaluated Account constants vs initialized:
```apex
public static AccountConsts ORDER = new AccountConsts();
public static AccountConsts ORDER { get {return new AccountConsts();} }
```