# CartJS.Utils
# Utility methods.
# ----------------

CartJS.Utils =

  # Returns the given object with each key wrapped with the text specified by
  # the 'type' parameter and square brackets, suitable for passing as a POST
  # variable to Shopify. 'type' defaults to 'properties'.
  #
  # For example, {"size": "xs"} becomes {"properties[size]": "xs"}.
  #
  # If 'override' is provided, the actual values in obj will be ignored and
  # all values will be set to that of the override. This is primarily useful
  # when wanting to reset values by setting them to an empty string. Note
  # null values for override will be ignored.
  wrapKeys: (obj, type = 'properties', override) ->
    wrapped = {}
    for key, value of obj
      wrapped["#{type}[#{key}]"] = if override? then override else value
    wrapped

  # Perform the opposite function to wrapKeys.
  #
  # For example, {"properties[size]": "xs"} becomes {"size": "xs"}.
  unwrapKeys: (obj, type = 'properties', override) ->
    unwrapped = {}
    for key, value of obj
      unwrappedKey = key.replace("#{type}[", "").replace("]", "")
      unwrapped[unwrappedKey] = if override? then override else value
    unwrapped

  # Extend a source object with the properties of another object (shallow copy).
  extend: (object, properties) ->
    for key, val of properties
      object[key] = val
    object

  # Clone a source object (deep copy).
  clone: (object) ->
    if not object? or typeof object isnt 'object'
      return object
    newInstance = new object.constructor()
    for key of object
      newInstance[key] = clone object[key]
    return newInstance