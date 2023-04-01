# MAIInspections -> is a test software to check the whole abilities of CoreData(Operations CRUD and what's the object-related database) 
## Functionality 
    I didn't implement many additional functionality inside the software's logic. At the moment I explored Create and Read abilities of abbreviation CRUD. 
## Frameworks 
    1. Firebase 
    2. Coredata
    3. SDWebImage 
    4. SwiftLint
## Frameworks FYI
    SwiftLint, which been implemented in the project is temporary unused. To activate it, please, follow the next steps: MAIInspections -> Build Phases -> + (Run additional script) and insert in command line: ${PODS_ROOT}/SwiftLint/swiftlint, because I installed it via Cocoapods. 
## Dependecies manager 
    1. Cocoapods
## Step's to test: 

1. When you touch bottomed button Add Violator you will be moved to other screen, where you will be able to create object of person, that will be implemented in the local database(CoreData) if you had filled all textFields before.
2. Keep in mind, that it's on untested way of development, so, the data you will write -> tha data will be kept. 
3. Perfomance optimizations didn't passed yet. I just realized logic of data-keeping, without any additional functionality, as I mentioned before. 
4. Once you selected image with UIImagePickerController, it will be placed on background of selectional button. 
5. When you will fill all required fields and press button create, you will be redirected to root screen, where your new added violator appears in the end of the list
6. You can search, if violator presents in database, just keep in mind, that you are able to SEARCH only by CAR'S NUMBER DETAILS (FIC777,MDA123,DATA345). Register isn't related to the searching result(Text, that you will input is automatically uppercased)

