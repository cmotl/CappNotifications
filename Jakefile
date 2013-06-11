/*
 * Jakefile
 * Notifications
 *
 * Created by You on June 11, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("Notifications", function(task)
{
    ENV["OBJJ_INCLUDE_PATHS"] = "Frameworks";

    if (configuration === "Debug")
        ENV["OBJJ_INCLUDE_PATHS"] = FILE.join(ENV["OBJJ_INCLUDE_PATHS"], configuration);

    task.setBuildIntermediatesPath(FILE.join("Build", "Notifications.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("Notifications");
    task.setIdentifier("com.yourcompany.Notifications");
    task.setVersion("1.0");
    task.setAuthor("Your Company");
    task.setEmail("feedback @nospam@ yourcompany.com");
    task.setSummary("Notifications");
    task.setSources(new FileList("**/*.j").exclude(FILE.join("Build", "**")).exclude(FILE.join("Frameworks", "Source", "**")));
    task.setResources(new FileList("Resources/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

task ("default", ["Notifications"], function()
{
    printResults(configuration);
});

task ("build", ["default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "Notifications", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "Notifications", "index.html")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "Notifications"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "Notifications"), FILE.join("Build", "Deployment", "Notifications")]);
    printResults("Deployment")
});

task ("desktop", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Desktop", "Notifications"));
    require("cappuccino/nativehost").buildNativeHost(FILE.join("Build", "Release", "Notifications"), FILE.join("Build", "Desktop", "Notifications", "Notifications.app"));
    printResults("Desktop")
});

task ("run-desktop", ["desktop"], function()
{
    OS.system([FILE.join("Build", "Desktop", "Notifications", "Notifications.app", "Contents", "MacOS", "NativeHost"), "-i"]);
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "Notifications"));
    print("----------------------------");
}
