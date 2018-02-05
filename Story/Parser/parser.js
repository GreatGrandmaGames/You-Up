const fs = require("fs");
const FILEPATH_EXPORTS = "/Users/carlosmichaelrodriguez/documents/projects/you_up/You-Up/Story/Parser/exports/";

//make this a command line argument later
const currentFileName = "json/tests/test_case_2_5_18.json";
const file = fs.readFileSync(currentFileName,"utf8");
const jsonFile = JSON.parse(file);
//helper functions, will put in another place later
function tabMeUpBaby(strings)
{
  let string = "";
  for (let i = 0; i < strings.length; i++)
  {
    string += strings[i] + "\t";
  }
  return string;
}
function createDateString()
{
  const d = new Date();
  return(d.getDate() + "-" + d.getFullYear() + "_" + d.getHours() + "-" + d.getHours() + "-" + d.getMinutes());
}
//TODO: Actually build the Parser

function parser(jsonFile)
{
  for (let i = 0; i < passages.length; i++)
  {
    const currentPassage = passages[i];
    let name, messageID, nextMessage, message;
    let option0, option0next, option1, option1next, option2, option2next, triggerID = "";
    name = getName(currentPassage.text);
    messageID = currentPassage.pid;
    //check if there are options
    if (currentPassage.links.length > 1)
    {
      nextMessage = -1;
      for (let x = 0; x < links.length; x++)
      {
        //TODO
        //nevermind, this is dumb. re-write this slightly so there are an array of option objects we
        //can just append as strings.
        //TODO
      }
    }
    else
    {
      nextMessage = currentPassage.links[0].pid;
    }
    message = getMessage(currentPassage.text);
  }
}
function getName(string)
{
  //getName from string (passages[i].text value) ("using # delimiters")
}
function getMessage(string)
{
  //getMessage from strin g(passages[i].text value)
}












//fileBuilder
const line0arr = ["name", "messageID", "nextMessage", "message", "option0", "option0next", "option1", "option1next", "option2", "option2next", "triggerID"];
const line0 = tabMeUpBaby(line0arr);

const fileName = createDateString();
fs.writeFile(FILEPATH_EXPORTS + fileName + ".tsv", line0, "utf8", function (err) {
    if (err) {
        return console.log(err);
    }
    console.log(fileName + " was created in: " + FILEPATH_EXPORTS);
});


/*
Ideas?
class Line = {
  constructor(name, messageID, nextMessage, message, options, triggerID)
  {
    this.name = name;
    this.messageID = messageID;
    this.nextMessage = nextMessage;
    this.message = message;
    this.options = options;
    this.triggerID = triggerID;
  }
};
class Option = {
  constructor(option, next)
  {
    this.option = option;
    this.next = next;
  }
};
*/
