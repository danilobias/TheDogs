# The Dogs

A small app that must two tabs with dog breeds images. The first tab show a screen with a list of dog breeds images and the second tab show a screen with a list of dog breeds when you search by breed name.

The pictures can be acquired from the following API: The Dog API (https://thedogapi.com/). 

## Features:

- List of breeds:
	1. Move from a list view into a grid view and take use of pagination.
	2. Order alphabetically.
	3. Show only the dog breed image and the name.
	4. Pressing on one of the list elements, should go to the details view.

- Search:
	1. Show a Search Bar where you can search by breed name 
	2. Show the list of results with the following Info per element:
		- Breed Name
		- Breed Group
		- Origin
	3. Pressing one of the elements should go to the details view

- Details:
	1. The detail view contain the following info: 
		- Breed Name
		- Breed Category
		- Origin
		- Temperament
## ToDo
- [ ] Offline functionality
- [ ] Error Handling

## Used Libraries
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
- [ProgressHUD](https://github.com/relatedcode/ProgressHUD)
