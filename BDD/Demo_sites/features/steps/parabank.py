from behave import *
import function.functions

@given("User clicks new register")
def register_user(self):
    function.functions.register_users(self)

@when("User enters valid details")
def enter_details(context):
    function.functions.enter_details(context)


