![logo](http://www.mortgageclub.io/assets/mortgageclubLOGO-5d49c4f9105893724104ce9b480ce03ebcf9f034b6e938da552c659903746da4.png)

##Background

At MortgageClub, we have free catered lunch everyday. Previously, (1) our assistant would ask us what we want for lunch, (2) we then go to the restaurant website (giachanhcamtuyet, for example), (3) choose what we want to eat, (4) tell the assistant, and finally (5) she would place an order on the restaurant website.

We thought that we could create a Slackbot to automate all of these steps. So our team spent 1 day to code it up as a year-end fun project. We thought it might be useful to other engineering teams in Vietnam as well so we've made it public. Here are a few features that you can add to this Slackbot:
- Ask for delivery information: name, address, phone number... instead of hardcoding it
- Add more lunch providers to the application

##How it works
![workflow](http://s30.postimg.org/gt3vrs5zl/happy_lunch_workflow_1.png)

##Usage
### Menu
 - Slack channel will receive today's menu in this format:

>   1. Bò xốt tiêu xanh - bánh mì - 33000.0 VND
  2. Ba chỉ xào ruốc sả - 29000.0 VND
  3. Cá rô chiên giòn - 29000.0 VND
  4. Gà xào cari - 29000.0 VND
  5. Ếch xào lăn - 33000.0 VND

- Every dish has a format:  *{item-number}  {dish-name} - {price}*

### Place an order
 Members use these command to place orders.

  **One dish** *#happylunch item-number*.

 - Ex: #happylunch 1

**Several dishes** *#happylunch item-number1,{space}item-number2,{space}item-number3*.
 - Ex: #happylunch 1, 2, 3

##How to deploy
- Implement Slack's webhook
 - Implement [Slack's Incoming Webhook](https://api.slack.com/incoming-webhooks).
 - Implement [Slack's Outgoing Webhooks](https://api.slack.com/outgoing-webhooks).
 - Outgoing's Trigger Word: #happylunch (or whatever you like)
 - Outgoing's URL: http://your-domain/lunch/order
 - Notice: your channel you choose will be a place members place orders.

- Set *Slack authentication token* to environment variable. [See more](https://api.slack.com/methods/chat.postMessage)

 ```
 SLACK_TOKEN=xoxp-your-authentication-token-XXYY
```

- Set up a scheduler to call below rake tasks. You can choose your ideal time.

``` ruby
# 8:30 AM get menu from GiaChanhCamTuyet & send menu to Slack
rake slack:get_menu

# 9:00 AM remind members who haven't ordered lunch
rake slack:remind_members_order_lunch

# 9:30 AM order lunch automatically
rake slack:order_lunch
```
