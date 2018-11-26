# StartUpRating

This is a test repository to experiment with new architecture, development practices and technologies

## Architecture

The chosen architecture is and adapted MVP, which has the goal to make the view dumb as it can be, so the presenter has the business logic and it is more testable than a complex view would be.

## Third-party

### GraphQL

The chosen iOS client was Apollo, which made it easy to query the data with just enough attributes that we need in the application.

### Firestore Realtime Database

A Google realtime database based on a structure of documents and collections. Creating and updating data is easy with the Firebase/Firestore iOS client.

### Cosmos

A stars view that can be updated on touch to get the user feedback on a five or more stars rate.

## Next steps

Now that the implementation is close to a real app, I should start implementing the unit tests to check if the chosen architecture is actually more testable, or if the architecture was correctly implemented.

An improvement in UI/UX definitely is quite doable with better components, flow and animations.

