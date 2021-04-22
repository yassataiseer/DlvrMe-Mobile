# DlvrMe


DlvrMe-Mobile is a project made by Yassa Taiseer that is used to make delivering packages with a city easier
  - Users signup/login
  - This is currently an open source project
  - They can then post an order worldwide and another user can drop it off somewhere else
  - Basically uber eats but anyone can deliver and make money
  - This Project has also been made on the web, view here: https://github.com/yassataiseer/delivrme
  - This is a cross platform project available to both mac and ios
  - The flutter app goes to a rest Api made with Python and Flask
  - ```DlvrMe-Api```is the folder for the Api
  - The Api code can also be found here: https://github.com/yassataiseer/DlvrMe-API

### Tech Stack:
  - Flask(backend)
  - MySQL(Backend)
  - Flutter(Frontend)



### Installation
Requires python 3
Requires Flutter
Android Studio
#### Mac& Linux(Rest-Api):
```sh
python3 app.py
```
#### Windows(Rest-Api):
```sh
python app.py
```
###Flutter App:
-Open project and run in android studio

### Building Database
DlvrMe runs on a MySQL databases
There is a need for two tables Users and Deliveries

#### User's Tables
The user's table will look like this:
|VALUE| TYPE  |
| ------ | ------ |
| Username | VARCHAR |
| Password | VARCHAR |

#### Deliveries Database
| VALUE  | TYPE |
| ------ | ------ |
| Username | VARCHAR |
| Address | VARCHAR |
| Latitude | FLOAT |
| Longitude | FLOAT |
| Item | VARCHAR |
| Price | FLOAT |
| User_info | VARCHAR |


### Open Sourcing Opportunities
Read ```CODE_OF_CONDUCT.md``` for proper rules
Instructions will come soon regarding what needs
to be improved.
