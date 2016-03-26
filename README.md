![Screenshots] (http://s7.postimg.org/h9sbbj0ob/Screen_Shot_2016_03_26_at_3_17_47_PM.png)
![Screenshots] (http://s14.postimg.org/hcpaag8td/Screen_Shot_2016_03_26_at_3_22_53_PM.png)

##Background

At MortgageClub, we have free catered lunch everyday. Previously, (1) our assistant would ask us what we want for lunch, (2) we then go to the restaurant website (giachanhcamtuyet, for example), (3) choose what we want to eat, (4) tell the assistant, and finally (5) she would place an order on the restaurant website.

We thought that we could create a Slackbot to automate all of these steps. So our team spent 2 days to code it up as a year-end fun project. We thought it might be useful to other engineering teams in Vietnam as well so we've made it public.

##How it works
![workflow](http://s2.postimg.org/o0ry898mx/updated_31_12_happy_lunch_workflow.png)

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

##Install
- Implement Slack's webhook
 - Implement [Slack's Incoming Webhook](https://api.slack.com/incoming-webhooks).
 - Implement [Slack's Outgoing Webhooks](https://api.slack.com/outgoing-webhooks).
 - Outgoing's Trigger Word: #happylunch (or whatever you like).
 - Outgoing's URL: http://your-domain/orders
 - Notice: your channel you choose will be a place members place orders.

- Deploy the Rails app to a hosting provider. **Notice:** if you don't use Heroku, you need to install [PhantomJS](http://phantomjs.org) in your server.

- Set contact information, [Slack's authentication token](https://api.slack.com/methods/chat.postMessage) and [Slack's outgoing token](https://api.slack.com/outgoing-webhooks) to environment variables.

 ```
 FULLNAME='Nguyen Van A'
 ADDRESS='93bis Nguyen Văn Thu, P. Da Kao, Q.1'
 TELEPHONE=097990xxyy
 EMAIL=nguyenvana@gmail.com
 SLACK_TOKEN=xoxp-your-authentication-token-XXYY
 OUTGOING_TOKEN=sk15-your-outgoing-token-XXYY
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

## Demo
See demo images at demo.html

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md).

Thank you, [contributors]!

[contributors]: https://github.com/mortgageclub/happylunch/graphs/contributors

## LICENSE
MIT License. Copyright 2015-2016 MortgageClub.
