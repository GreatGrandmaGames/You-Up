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
class Option {
  constructor(option, next)
  {
    this.option = option;
    this.next = next;
  }
};
//TODO: Actually build the Parser

function parser(jsonFile)
{
  let finalString = "";
  for (let i = 0; i < jsonFile.passages.length; i++)
  {
    const currentPassage = jsonFile.passages[i];
    let name, messageID, nextMessage, message, triggerID;
    const options = [];
    name = getName(currentPassage.text);
    name = "$" + name;
    messageID = currentPassage.pid;
    if (currentPassage.links === undefined)
    {
      nextMessage = -777;
    }
    else
    {
      //check if there are options
      if (currentPassage.links.length > 1)
      {
        nextMessage = -1;
        for (let x = 0; x < currentPassage.links.length; x++)
        {
          options.push(new Option(currentPassage.links[x].name, currentPassage.links[x].pid));
        }
      }
      else
      {
        nextMessage = currentPassage.links[0].pid;
      }
    }
    if (currentPassage.tags === undefined)
    {
      triggerID = -9999;
    }
    else
    {
      triggerID = currentPassage.tags[0];
    }
    message = getMessage(currentPassage.text);
    const arr = [name, messageID, nextMessage, message, triggerID];
    for (let y = 0; y < options.length; y++)
    {
      arr.push(options[y].option);
      arr.push(options[y].next);
    }
    console.log(name);
    finalString += tabMeUpBaby(arr) + "\n";
  }
  return finalString;
}
function getName(string)
{
  //the name is between the pound key
  const s = string.split("#");
  return(s[1]);
  //getName from string (passages[i].text value) ("using # delimiters")
}
function getMessage(string)
{
  // the message is within the first and second \n's
  const s = string.split("\n");
  return s[1];
  //getMessage from strin g(passages[i].text value)
}

//fileBuilder
const line0arr = ["name", "messageID", "nextMessage", "message", "triggerID", "option0", "option0next", "option1", "option1next", "option2", "option2next"];
let fileContent = tabMeUpBaby(line0arr) + "\n";
fileContent += parser(jsonFile);
const fileName = createDateString();
fs.writeFile(FILEPATH_EXPORTS + fileName + ".tsv", fileContent, "utf8", function (err) {
    if (err) {
        return console.log(err);
    }
    console.log(fileName + " was created in: " + FILEPATH_EXPORTS);
});


/*
Ideas?
class Line ={
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
