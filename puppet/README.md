Make sure kitchen, vagrant, inspec, and ansible are installed
NOT WORKING! 

###### Pre Reqs:
- Install kitchen-ansible gem file: `chef gem install kitchen-puppet`  


###### Running the Tests:

0. Make sure you are within the `puppet` folder  

1. `kitchen converge`

2. `kitchen verify`  

3. Test for Compliance. Change the test within the `kitchen.yml` file  

4. `kitchen verify`  

5. `kitchen destroy`  