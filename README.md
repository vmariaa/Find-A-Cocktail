
# Find A Cocktail

A simple app allowing user to easily search for cocktails based on an ingredient.
The app is using TheCocktailDB API. Search results are displayed in a list; each result can be tapped
to display ingredients, their measurements, as well as a needed glass type and instructions on how to prepare chosen drink.
The user can search for an ingredient that also consists of multiple words (such as "orange juice").

If the ingredient searched by the user is not included in the API - an alert pops out.

In case of a longer loading time/time to fetch the information from API, and activity indicator is being displayed in adequate areas.

Due to some drinks not having their ingredients or instructions set properly by the creators of the API, the app shows "not specified" in those sections
that are for some reason lacking either one or the another. Some steps have been undertaken to also assure that all instructions are displayed with a capital letter (which otherwise was an issue).

The app supports both light and dark mode, as well as different screen sizes (on smallest devices, the "ingredients" and "instructions" areas are scrollable) and iOS versions down to iOS 11.

Used architecture: MVC

Screenshots:

1. Launch Screen

![](/Screenshots/7%20DRINK.png)

2. Main Screen

![](/Screenshots/3%20DRINK.png) ![](/Screenshots/1%20DRINK.png) ![](/Screenshots/6%20DRINK.png) ![](/Screenshots/8%20DRINK.png)

3. Alert

![](/Screenshots/4%20DRINK.png)

4. Second (detail) screen

![](/Screenshots/2%20DRINK.png) ![](/Screenshots/5%20DRINK.png)

