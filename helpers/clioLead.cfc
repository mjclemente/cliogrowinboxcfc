/**
* cliogrowinbox.cfc
* Copyright 2020 Matthew Clemente, John Berquist
* Licensed under MIT
*/
component accessors="true" {

  property name="from_first" default="";
  property name="from_last" default="";
  property name="from_message" default="";
  property name="from_email" default="";
  property name="from_phone" default="";
  property name="referring_url" default="";
  property name="from_source" default="";

  /**
  * @hint You can init this component with any/all properties, but you don't need to supply any. When creating a lead, all fields are required except for :
    * from_email,
    * from_phone
  */
  public any function init( 
    string from_first, 
    string from_last, 
    string from_message, 
    string from_email, 
    string from_phone, 
    string referring_url, 
    string from_source 
  ) {

    if ( arguments.keyExists( 'from_first' ) )
      setFrom_first( from_first );

    if ( arguments.keyExists( 'from_last' ) )
      setFrom_last( from_last );

    if ( arguments.keyExists( 'from_message' ) )
      setFrom_message( from_message );

    if ( arguments.keyExists( 'from_email' ) )
      setFrom_email( from_email );

    if ( arguments.keyExists( 'from_phone' ) )
      setFrom_phone( from_phone );

    if ( arguments.keyExists( 'referring_url' ) )
      setReferring_url( referring_url );

    if ( arguments.keyExists( 'from_source' ) )
      setFrom_source( from_source );

    variables.utcBaseDate = dateAdd( "l", createDate( 1970,1,1 ).getTime() * -1, createDate( 1970,1,1 ) );

    return this;
  }

  /**
  * @hint Sets the first name
  */
  public any function from_first( required string from_first ) {
    setFrom_first( from_first );
    return this;
  }

  /**
  * @hint convenience method
  */
  public any function firstName( required string from_first ) {
    return this.from_first( from_first );
  }

  /**
  * @hint Sets the last name
  */
  public any function from_last( required string from_last ) {
    setFrom_last( from_last );
    return this;
  }

  /**
  * @hint convenience method
  */
  public any function lastName( required string from_last ) {
    return this.from_last( from_last );
  }

  /**
  * @hint Sets the message
  */
  public any function from_message( required string from_message ) {
    setFrom_message( from_message );
    return this;
  }

  /**
  * @hint convenience method
  */
  public any function message( required string from_message ) {
    return this.from_message( from_message );
  }

  /**
  * @hint Sets the email address
  */
  public any function from_email( required string from_email ) {
    setFrom_email( from_email );
    return this;
  }

  /**
  * @hint convenience method
  */
  public any function email( required string from_email ) {
    return this.from_email( from_email );
  }

  /**
  * @hint Sets the phone number
  */
  public any function from_phone( required string from_phone ) {
    setFrom_phone( from_phone );
    return this;
  }

  /**
  * @hint convenience method
  */
  public any function phone( required string from_phone ) {
    return this.from_phone( from_phone );
  }

  /**
  * @hint Sets the referring url
  */
  public any function referring_url( required string referring_url ) {
    setReferring_url( referring_url );
    return this;
  }

  /**
  * @hint convenience method
  */
  public any function referringUrl( required string referring_url ) {
    return this.referring_url( referring_url );
  }

  /**
  * @hint Sets the source
  */
  public any function from_source( required string from_source ) {
    setFrom_source( from_source );
    return this;
  }

  /**
  * @hint convenience method
  */
  public any function source( required string from_source ) {
    return this.from_source( from_source );
  }

  /**
  * @hint A very simple build() that does not require any custom serialization methods via onMissingMethod(), like other helpers.
  */
  public string function build() {

    var body = '';
    var properties = getPropertyValues();
    var count = properties.len();

    properties.each(
      function( property, index ) {
        body &= '"#property.key#": ' & serializeJSON( property.value ) & '#index NEQ count ? "," : ""#';
      }
    );

    return '{' & body & '}';
  }

  /**
  * @hint Similar to struct, but returns the data as a struct
  */
  public struct function buildStruct() {
    var body = {};
    var properties = getPropertyValues();

    properties.each(
      function( property, index ) {
        body["#property.key#"] = property.value;
      }
    );

    return body;
  }

  /**
  * helpful: https://www.epochconverter.com/
  * @hint API does Unix epoch in milliseconds, instead of seconds, so we multiply by 1000. Example: 1508369194377
  */
  private numeric function getUTCTimestamp( required date dateToConvert ) {
    return dateDiff( "s", variables.utcBaseDate, dateToConvert ) * 1000;
  }

  /**
  * @hint converts the array of properties to an array of their keys/values, while filtering those that have not been set
  */
  private array function getPropertyValues() {

    var propertyValues = getProperties().map(
      function( item, index ) {
        return {
          "key" : item.name,
          "value" : getPropertyValue( item.name )
        };
      }
    );

    return propertyValues.filter(
      function( item, index ) {
        if ( isStruct( item.value ) )
          return !item.value.isEmpty();
        else
          return len( item.value );
      }
    );
  }

  private array function getProperties() {

    var metaData = getMetaData( this );
    var properties = [];

    for( var prop in metaData.properties ) {
      if( !prop.keyExists( 'required' ) || prop.required )
        properties.append( prop );
    }

    return properties;
  }

  private any function getPropertyValue( string key ){
    var method = this["get#key#"];
    var value = method();
    return value;
  }
}