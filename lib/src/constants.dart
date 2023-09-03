class Constants {
  static String baseUrl = "127.0.0.1:8000";
  static String apiUrl = "http://127.0.0.1:8000";
  static String appName = "TheMakerSpace";

  static String returnFormPageName = "returnFormPage";
  static String componentsPageName = "componentsPage";
  static String homePageName = "homePage";
  static String borrowPageName = "borrowPage";

  static Map<String, dynamic> fakeUser = {
    "url": "http://127.0.0.1:8000/rest/users/1/",
    "id": 1,
    "username": "bob",
    "user_id": 108503,
    "email": "bob@gmail.com",
    "token": "5e4ca59106f12538a93f3004461534c42f10c872"
  };

  static Map<String, dynamic> fakeComponent = {
    "url": "http://127.0.0.1:8000/rest/components/1/",
    "unique_id": "400e983c-6a5b-48ed-82d8-f6e1ad9f5144",
    "name": "",
    "sku": "6969",
    "mpn": "6969",
    "upc": 0,
    "storage_bin": [
      {
        "url": "http://127.0.0.1:8000/rest/storage_bins/1/",
        "name": "drill bits",
        "short_code": null,
        "unit_row": "1",
        "unit_column": "1",
        "storage_unit": {
          "url": "http://127.0.0.1:8000/rest/storage_units/1/",
          "name": "drills",
          "short_code": null,
          "room": {
            "url": "http://127.0.0.1:8000/rest/rooms/1/",
            "name": "Makerspace",
            "short_code": null,
            "building": {
              "url": "http://127.0.0.1:8000/rest/buildings/1/",
              "name": "Montgomery Tang",
              "address": "",
              "postcode": ""
            }
          }
        }
      }
    ],
    "measurement_unit": {
      "url": "http://127.0.0.1:8000/rest/component_measurements/1/",
      "unit_name": "bit",
      "unit_description": "a drill bit"
    },
    "qty": 17,
    "description": "Sturdy drill bit made by a trusted brand"
  };

  static Map<String, dynamic> fakeBorrow = {
    "url": "http://127.0.0.1:8000/rest/borrows/29/",
    "qty": 0,
    "person_who_borrowed": {
      "url": "http://127.0.0.1:8000/rest/users/1/",
      "username": "6969",
      "user_id": 696969,
      "email": "bob@gmail.com"
    },
    "timestamp_check_out": "2012-09-04T06:00:00Z",
    "timestamp_check_in": null,
    "borrow_in_progress": true,
    "component": {
      "url": "http://127.0.0.1:8000/rest/components/1/",
      "unique_id": "400e983c-6a5b-48ed-82d8-f6e1ad9f5144",
      "name": "",
      "sku": "",
      "mpn": "",
      "upc": 0,
      "qty": 3,
      "description": "Sturdy drill bit made by a trusted brand",
      "barcode": "http://127.0.0.1:8000/media/barcodes/barcode.png",
      "measurement_unit": {
        "url": "http://127.0.0.1:8000/rest/component_measurements/1/",
        "unit_name": "bit",
        "unit_description": "a drill bit"
      },
      "storage_bin": [
        {
          "url": "http://127.0.0.1:8000/rest/storage_bins/1/",
          "name": "drill bits",
          "short_code": null,
          "unit_row": "1",
          "unit_column": "1",
          "storage_unit": {
            "url": "http://127.0.0.1:8000/rest/storage_units/1/",
            "name": "drills",
            "short_code": null,
            "room": {
              "url": "http://127.0.0.1:8000/rest/rooms/1/",
              "name": "Makerspace",
              "short_code": null,
              "building": {
                "url": "http://127.0.0.1:8000/rest/buildings/1/",
                "name": "Montgomery Tang",
                "address": "",
                "postcode": ""
              }
            }
          }
        }
      ]
    }
  };
}
