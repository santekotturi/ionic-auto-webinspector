# ionic-auto-webinspector


## What is it:

An ionic demo app with two hooks for automatically launching the Safari Web Inspector after you run your app in the simulator or on your iOS device. 

## How to use it:

### Step 1:

#### Simulator:

You need to change a single variable in the script, what your initial view name is. 

On line 9:

`set initial_view to "Home"`

Where `initial_view` should be the initial page your app bootstraps. For ionic2/3 starters, this is `"Home"`. For all ionic-v1 apps, yours will *always* be `"index.html"`. 

If you're not sure what yours is, launch your app in Xcode as you normally would. Then go to Develop > Simulator and you'll see what your initial view name is:

![Screenshot 1](/readme_imgs/screenshot1.png?raw=true "How to find your initial view name")

#### Device:

You have to change two variables in the script, your device name and the initial view name.

See the section above for how to change your initial view name. 

For your device name, on your iPhone. Settings > General > About > Name.

OR (with your phone plugged in ), the name appears in Safari menu > Develop. 

![Screenshot 2](/readme_imgs/screenshot2.png?raw=true "Find Device Name")

### Step 2:
Once you've configured these, make the two applescripts in `/scripts` executable:

`chmod 755 scripts/*.applescript` 

### Step 3:
Run your app in the simulator: `ionic emulate ios`

Run your app on your device: `cordova run ios` (at the time of writing, `ionic run ios` was causing errors for me.)

Step 3 because if you head over to `config.xml`, we've got:

```
  <platform name="ios">
    <hook type="after_emulate" src="scripts/deploy-webinspector-on-simulator.applescript"/>
    <hook type="after_run" src="scripts/deploy-webinspector-on-device.applescript"/>
    ...
```

When running this the first time, you might have System Preferences come up and ask for Accessibility permissions, just allow iTerm or Terminal or whatever shell you're using permission so that it can open Safari menus for you. 

### Step 4:
There is no step 4.


## To run this in your own app:

### Step 1:
Copy the two scripts inside `/scripts` to your project (make a `/scripts` directory if you dont have one or put them somewhere else, just change the path in config.xml)

### Step 2:
Add the hooks to your `config.xml`.

Done. 

## NOTES: 

Some of you might be wondering why this way and why not inside `/hooks/after_emulate`. Those scripts get run for both ios and android, obviously this wont work for Android because you have to go to `chrome://inspect` and then click a link on a webpage - not something applescript can do. perhaps theres a way to do this with a webscraper... In normal bash and js scripts, you can access the CORDOVA variables passed and figure out if android or ios is being run but I couldnt figure out how to do that in Applescript. If you can find a way, please submit a PR! 

This is obviously a pretty big hack but once you've got it setup, it does work consistently. 


# Changelog

0.0.0 - Basics are working

0.1.0 - Added auto-refresh. Removed the "final" click :)