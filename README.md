# clioGrowInboxCFC
A CFML wrapper for the [Clio Grow Inbox API](https://support.clio.com/hc/en-us/articles/360014305753-Clio-Grow-Lead-Inbox).  
This integration makes it possible to post leads to a Clio Grow Inbox.

### Acknowledgements

This project borrows heavily from the API frameworks built by [jcberquist](https://github.com/jcberquist), such as [aws-cfml](https://github.com/jcberquist/aws-cfml). Because it builds on these earlier projects, it is also licensed under the terms of the MIT license.

## Table of Contents

- [Quick Start](#quick-start)
- [`clioGrowInboxCFC` Reference Manual](#reference-manual)
- [Reference Manual for `helpers.clioLead`](#reference-manual-for-helperscliolead)
- [Questions](#questions)
- [Contributing](#contributing)

## Quick Start
Here's how to quickly post a lead to your Clio Grow Inbox:

```cfc
cgInbox = new path.to.cliogrowinboxcfc.cliogrowinbox( inbox_lead_token = 'xxx' );

result = cgInbox.addLead(
  from_first = "Buster",
  from_last = "Bluth",
  from_message = "I was made to understand that there would be grilled cheese sandwiches here.",
  from_email = "test@test.com",
  from_phone = "999-999-9999",
  referring_url = "https://www.thebananastand.com",
  from_source = "Banana Stand"
);
writeDump( var='#result#', abort='true' );
```

## Reference Manual

#### `addLeadData( required string from_first, required string from_last, required string from_message, string from_email = '', string from_phone = '', required string referring_url, required string from_source )`
Posts a lead to the Inbox, providing all the relevant lead data individually.

#### `addLead( required any lead )`
Posts a lead to the Inbox, providing the data as a single helper object or struct. The `lead` argument should be an instance of the `helpers.clioLead` component. However, if you want to create and pass in the struct or JSON yourself, you can.


## Reference Manual for `helpers.clioLead`
This section documents every public method in the `helpers/clioLead.cfc` file. All methods can be chained, and are simply used to more easily construct the lead object. That is, the object can be built like this:

```cfc
lead = new path.to.cliogrowinboxcfc.helpers.cliolead()
  .firstName( "Buster" )
  .lastName( "Bluth" )
  .message( "I was made to understand that there would be grilled cheese sandwiches here." )
  .referringUrl( "https://www.thebananastand.com" )
  .source( "Banana Stand" );
```

#### `from_first( required string from_first  )`
Set's the first name

#### `firstName( required string from_first  )`
Convenience method to set the first name

#### `from_last( required string from_last  )`
Set's the last name

#### `lastName( required string from_last  )`
Convenience method to set the last name

#### `from_message( required string from_message  )`
Set's the message

#### `message( required string from_message  )`
Convenience method to set the message

#### `from_email( required string from_email  )`
Set's the email

#### `email( required string from_email  )`
Convenience method to set the email

#### `from_phone( required string from_phone  )`
Set's the phone

#### `phone( required string from_phone  )`
Convenience method to set the phone

#### `referring_url( required string referring_url  )`
Set's the referring URL

#### `referringUrl( required string referring_url  )`
Convenience method to set the referring URL

#### `from_source( required string from_source  )`
Set's the source

#### `source( required string from_source  )`
Convenience method to set the source

## Questions
For questions that aren't about bugs, feel free to hit me up on the [CFML Slack Channel](http://cfml-slack.herokuapp.com); I'm @mjclemente. You'll likely get a much faster response than creating an issue here.

## Contributing
:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

Before putting the work into creating a PR, I'd appreciate it if you opened an issue. That way we can discuss the best way to implement changes/features, before work is done.

Changes should be submitted as Pull Requests on the `develop` branch.
---
