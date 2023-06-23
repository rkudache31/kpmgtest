#!/bin/python
#################################################################################################
## Script Name :- NestedObject.py
## Description :- A function where you pass in the object and a key and get back the value.
## Auther :-   Ravindra Kudache
#################################################################################################

#Get value funtion for get value from  nested object
def get_value_nested_object(obj, key):
    keys = key.split('/')  # Split the key into individual levels
    value = obj

    try:
        for k in keys:
            value = value[k]  # Access each level of the object
        return value
    except (KeyError, TypeError):
        return None  # Return None if the key is not found or object structure is incorrect

# Example usage:
obj1 = {"k": {"l": {"m": "r"}}}
key1 = "k/l/m"
value1 = get_value_nested_object(obj1, key1)
print(value1)  # Output: r

obj2 = {"x": {"b": {"v": "h"}}}
key2 = "x/b/v"
value2 = get_value_nested_object(obj2, key2)
print(value2)  # Output: h

