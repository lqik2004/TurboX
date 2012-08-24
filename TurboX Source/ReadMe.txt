SimpleScriptingProperties
=========================

ABOUT:

This sample is a follow-on to the SimpleScripting sample.  After completing the steps defined in that sample to setting up and creating a scriptable application, you can continue with the steps in this sample to add some properties to an application.


Step 1:  Setting up

Create a new .sdef file that includes the standard scripting suite and add it to your Xcode project.  Usually, this file will have the same name as your application.  Going along with that convention, the .sdef file in this sample has been named "SimpleScriptingProperties.sdef".  In the contents of that file, enter an empty dictionary that includes the standard AppleScript suite as follows:


<dictionary xmlns:xi="http://www.w3.org/2003/XInclude">

    <xi:include href="file:///System/Library/ScriptingDefinitions/CocoaStandard.sdef" xpointer="xpointer(/dictionary/suite)"/>

        <!-- add your own suite definitions here -->

</dictionary>


The important parts of this definition are as follows:

1. The 'xi' namespace declaration in the opening dictionary element declares that enclosed elements using the 'xi' namespace will follow conventions defined by the XInclude standard.  This will allow us to include the standard definitions.

2. The 'xi:include' element includes the Standard Suite in the .sdef.

NOTE: Prior to Mac OS X 10.5 developers would copy the standard suite from the ScriptingDefinitions sample (http://developer.apple.com/samplecode/ScriptingDefinitions/index.html) directly into their .sdef file.  For backwards compatibility with Mac OS X 10.4, you may continue to use that technique, but moving forward the XInclude technique described above is recommended.




Step 2: Add a starting suite

Add a new suite to your .sdef file at the end of the dictionary just before the closing </dictionary> tag:


    <suite name="Simple Scripting Properties Suite" code="SsPs"
        description="SimpleScriptingProperties application specific scripting facilities.">
        <!-- put your application specific scripting suite information here -->
         
    </suite>

It is inside of this suite definition where you will put your application specific scripting information.  You can add additional suites if you like and use them to group related scripting functionality together, but for most purposes one should be sufficient.




Step 3: Add an application class to your new script suite.

Here is our new suite with the application class added in:

    <suite name="Simple Scripting Suite" code="SScr"
        description="SimpleScripting application specific scripting facilities.">
        
        <!-- put your application specific scripting suite information here -->
        
        <class name="application" code="capp" 
                    description="Our simple application class." inherits="application">
                    
            <cocoa class="NSApplication"/>
            
            <!-- add your properties here -->
            
        </class>

    </suite>

Note, the application class we have added inherits from the application class defined in the Standard Suite in Skeleton.sdef.  

The application class is the root container class for an AppleScriptable application.  All of the root functionality provided by your application will be contained in this class and the other classes and objects that it contains.

Important points to note of here:
  - the suite has a unique four-character code associated with it 'SScr'. 
  - when selecting four character codes to pair together with terms you would
  like to use in AppleScript, you should always consult the AppleScript Terminology and Apple Event Codes table here:
  http://developer.apple.com/releasenotes/AppleScript/ASTerminology_AppleEventCodes/TermsAndCodes.html
  
  The four character codes you use for your terms you are using should always agree with the four character codes in that table.  If you are introducing new terms, then you should make sure the four character code you are using to represent that term isn't already in use by consulting that table.

  - the <cocoa class="NSApplication"/> part names the Objective-C class where Cocoa will look for the property accessor methods for the properties we define for our custom application AppleScript class.  For every property we define in the scripting definition for our application class, we will define appropriate accessor methods on the category of NSApplication defined in the SimpleApplication.h and SimpleApplication.m files.



Step 4: Add some properties to the scripting suite.


Here are the properties added to the application suite for this example:


(a) the 'special version' AppleScript read only string value property:

            <property name="special version" code="SiVs" description="the application version" type="text" access="r">
                <cocoa key="specialVersion"/>
            </property>
            
This property has been implemented as a string (type="text") and it is 'read only' (access="r").  We have specified a Cocoa key of 'specialVersion' so when trying to retrieve the value for this property Cocoa will call the getter method named 'specialVersion' on the NSApplication instance to retrieve the value.  Since this object has been declared as 'read only', we do not have to implement a setter method on the NSApplication instance.

AppleScript string properties correspond to the Objective-C NSString type.



(b) the 'input value' AppleScript read/write integer value property:

            <property name="input value" code="SiIv" description="an input integer value" type="integer" access="rw">
                <cocoa key="inputValue"/>
            </property>

This property has been implemented as an integer value (type="integer") and it is a read/write property (access="rw").  Since it is a read/write property we will have to provide both a setter and a getter method.  Since we have provided the Cocoa key 'inputValue' the getter method will be named 'inputValue' and the setter method will be named 'setInputValue'.

AppleScript integer properties correspond to the Objective-C NSNumber type.



(c) the 'scaling factor' AppleScript read/write floating point value property:

            <property name="scaling factor" code="SiSc" description="a real number property" type="real" access="rw">
                <cocoa key="scalingFactor"/>
            </property>

This property has been implemented as a floating point value (type="real") and it is a read/write property (access="rw").  Since it is a read/write property we will have to provide both a setter and a getter method.  Since we have provided the Cocoa key 'scalingFactor' the getter method will be named 'scalingFactor' and the setter method will be named 'setScalingFactor'.

AppleScript floating point properties correspond to the Objective-C NSNumber type.



(d) the 'output value' AppleScript read only floating point property:

            <property name="output value" code="SiOv"
                        description="the product of the input value and the scaling factor" type="real" access="r">
                <cocoa key="outputValue"/>
            </property>

This property has been implemented as a floating point value (type="real") and it is a read only property (access="r").  Since it is a read only property we will have to provide a getter method but not a setter.  Since we have provided the Cocoa key 'outputValue' the getter method will be named 'outputValue'.  The 'output value' is a calculated value and it is the product of the 'input value' property and the 'scaling factor' property.

AppleScript floating point properties correspond to the Objective-C NSNumber type.



(e) the 'description' AppleScript read/write string value property:

            <property name="description" code="desc" description="an example of a string value property" type="text" access="rw"/>

This property has been implemented a string value (type="text") and it is a read/write property (access="rw").  Since it is a read/write property we will have to provide both a setter and a getter method.  Here, we have not provided a Cocoa key value so Cocoa will go ahead an generate one for us.  In this case, the getter method will be named 'description' and the setter method will be named 'setDescription'.

AppleScript string properties correspond to the Objective-C NSString type.



(f) the 'ready' AppleScript read/write boolean value property:

            <property name="ready" code="SiRd" description="a boolean value property" type="boolean" access="rw"/>

This property has been implemented as a boolean value (type="boolean") and it is a read/write property (access="rw").  Since it is a read/write property we will have to provide both a setter and a getter method.  Here, we have not provided a Cocoa key value so Cocoa will go ahead an generate one for us.  In this case, the getter method will be named 'ready' and the setter method will be named 'setReady'.

AppleScript boolean properties correspond to the Objective-C NSNumber type.



(g) the 'modification date' AppleScript read/write date value property:

            <property name="modification date" code="asmo" description="last modified date" type="date" access="rw">
                <cocoa key="modificationDate"/>
            </property>

This property has been implemented as a date value (type="date") and it is a read/write property (access="rw").  Since it is a read/write property we will have to provide both a setter and a getter method.  Since we have provided the Cocoa key 'modificationDate' the getter method will be named 'modificationDate' and the setter method will be named 'setModificationDate'.

AppleScript date properties correspond to the Objective-C NSDate type.



(h) the 'simplicity level' AppleScript read/write custom enumeration value property:

            <property name="simplicity level" code="SsLv" description="the simplicity level" type="simplicitylevel" access="rw">
                <cocoa key="simplicityLevel"/>
            </property>

This property has been implemented as a custom enumeration value (type="simplicitylevel") and it is a read/write property (access="rw").  We have declared our custom enumeration earlier in the suite to include four elements:

        <enumeration name="simplicitylevel" code="SiLv">
            <cocoa name="SimplicityLevel"/>
            <enumerator name="Basic" code="SiBa" description="Basic">
                <cocoa name="Basic"/>
            </enumerator>
            <enumerator name="Introductory" code="SiIn" description="Introductory">
                <cocoa name="Introductory"/>
            </enumerator>
            <enumerator name="Advanced" code="SiAd" description="Advanced">
                <cocoa name="Advanced"/>
            </enumerator>
            <enumerator name="Difficult" code="SiDi" description="Difficult">
                <cocoa name="Difficult"/>
            </enumerator>
        </enumeration>

Since 'simplicity level' is a read/write property we will have to provide both a setter and a getter method.  Since we have provided the Cocoa key 'simplicityLevel' the getter method will be named 'simplicityLevel' and the setter method will be named 'simplicityLevel'.

AppleScript enumeration properties correspond to the Objective-C NSNumber type and you can use NSNumber's unsigned long accessor functions to retrieve the four letter codes associated with values in your enumerations.



(i) the 'simplicity factor' AppleScript read only floating point property:

            <property name="simplicity factor" code="SiFt"
                        description="a numeric representation of the simplicity factor" type="real" access="r">
                <cocoa key="simplicityFactor"/>
            </property>

This property has been implemented as a floating point value (type="real") and it is a read only property (access="r").  Since it is a read only property we will have to provide a getter method but not a setter.  Since we have provided the Cocoa key 'simplicityFactor' the getter method will be named 'simplicityFactor' in the Objective-C source.  The 'simplicity factor' is a calculated value and it is based on the value stored in the 'simplicity level' property.  The implementation of this property illustrates how you can use custom enumerations in your Objective-C code.

AppleScript floating point properties correspond to the Objective-C NSNumber type.



Step 5: Implement the setter and getter methods on a Category of NSApplication.


In this example we have provided the implementation for all of the necessary setter and getter methods in the SimpleApplication.m file.  Comments in that file provide more information about the implementation.  See the files SimpleApplication.h and SimpleApplication.m for more information.



Step 6:  Where to next?

Well, now that you have the very basics in hand, you're all ready to start adding scriptability to your application.  But, careful planning before you start adding in scripting features will be well worth your while.  So, please consider reading the following documentation.

- The items listed in the section "Implementing a Scriptable Application" on this page are essential reading.  Everyone new to scripting should read through these documents and familiarize themselves with the topics discussed.
http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ScriptableCocoaApplications/SApps_implement/SAppsImplement.html

- "Designing for Scriptability in Cocoa Scripting Guide provides a high-level checklist of design issues and tactics:
http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ScriptableCocoaApplications/SApps_design_apps/SAppsDesignApp.htmlE

- This Scripting Interface Guidelines document provides more detailed information you should consider when adding scriptability to your application: 
http://developer.apple.com/technotes/tn2002/tn2106.html

- The AppleScript terminology and Apple Event Codes document provides a listing of four character codes that area already defined for use with specific terms.  As you are adding terminology to your application you should always check there to see if a four character code has already been defined for a term you would like to use AND to make sure a four character code you would like to use is not already being used by some other terminology. 
http://developer.apple.com/releasenotes/AppleScript/ASTerminology_AppleEventCodes/TermsAndCodes.html

- NSScriptCommand class is the one you use for implementing verbs (aka commands) 
http://developer.apple.com/documentation/Cocoa/Reference/Foundation/Classes/NSScriptCommand_Class/Reference/Reference.html



Step 7:  And after that?

This sample is part of a suite of samples is structured as an incremental tutorial with concepts illustrated in one sample leading to the next in the order they are listed below.

SimpleScripting
	http://developer.apple.com/samplecode/SimpleScripting/
	
SimpleScriptingProperties (you are here)
	http://developer.apple.com/samplecode/SimpleScriptingProperties/
	
SimpleScriptingObjects
	http://developer.apple.com/samplecode/SimpleScriptingObjects/
	
SimpleScriptingVerbs
	http://developer.apple.com/samplecode/SimpleScriptingVerbs/




===========================================================================
BUILD REQUIREMENTS

Xcode 3.2, Mac OS X 10.6 Snow Leopard or later.

===========================================================================
RUNTIME REQUIREMENTS

Mac OS X 10.6 Snow Leopard or later.

===========================================================================
CHANGES FROM PREVIOUS VERSIONS

Version 1.1
- Replaced getter/setter method declarations with properties.
- Project updated for Xcode 4.
Version 1.0
- Initial Version

===========================================================================
Copyright (C) 2008-2011 Apple Inc. All rights reserved.