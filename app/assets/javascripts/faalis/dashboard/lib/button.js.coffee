# This class represent a button to use in **Faalis** views.
class Faalis.Button
  # options:
  # * **title**:     Title of the button
  # * **icon**:      Icon class to use in button
  # * **classess**:  Classes to assign the button element
  # * **route**:     Target route of the button, if any.
  # * **on_click**:  If provided it would have higher priority over **route**
  # * **permission**: Required permission for user.
  constructor: (options = {})->
    @title    = options.title
    @icon     = options.icon
    @classes  =  options.classes || "btn btn-sm"
    @route    = options.route
    @on_click = options.on_click

    @required_permission =  options.permission
