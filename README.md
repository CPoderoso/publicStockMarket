# publicStockMarket
Access to Stock Market data using OAuth. Needs an active investment account. Example worked with Ally Bank.

Accessing your Stock Investment Account using Python and PostgreSQL

Looking for ways to securely connect to your investment account, run some Python code to get your Stocks and Options data and store in PostgreSQL? If you answer yes, this article is for you. If you answer no, but you want to know how easy this process is, this article is for you as well.

I will cover some basic Python principles of programming, OAuth connection, psycopg2 usage to connect to PostgreSQL, and Python iterators / Context Manager.

I will split this article in three main parts: Python programming, visual analysis over collected data, and Predictive Algorithms to identify some behaviors. No… There is no guarantee that the Algorithm will help you became a millionaire. I will just use them to show how we can apply Data Science concepts in basically any kind of data.

Code is available in my Git account (https://github.com/CPoderoso).

So, fell free to use it and collaborate with Developers. My goal with this code is not extensively explore Python full potential to get the best possible code but show how easy it is creating an OAuth and PostgreSQL Python code.

With that being said, let’s start our journey.

Architecting the Solution
 
You can see that it is a quite simple diagram. 
Probably you are thinking why I did not create just one routine to process Stock and Option data, since both processes are similar. Yes… Probably I will think on that in the future releases and this will be an option discussion to my readers. I chose implementing, at least in this very first approach, two different methods. The simple explanation is that usually we collect different data from Stocks and from Options. I would need to create an “IF” to take a decision inside a single method if I want to keep just one. I am not sure if it would make my code easier to read and maintain.
I really love the old but useful cohesion and coupling software engineering principle. You can find more information regarding this here.
We will use OAuth1 to securely connect to an Investment Bank account. We will use psycopg2 to connect to PostgreSQL. You will need to install both before executing the program.

Analyzing our Code

I will comment each code part as it is used – not necessarily how I created in my Jupyter Notebook.

First things first, let’s see what modules we will use here.
 
We will use psycopg2 to connect and access PostgreSQL data. Json will be used to get Investment Bank account data and manipulate it in Python. Requests will be used to manage data from the Investment Bank account. Datetime does not need explanation, and ConfigParser to access our “.ini” files and parse connection variables for PostgreSQL and OAuth. Contextmanager will be used to iterate with PostgreSQL and finally OAuth1 to securely connect to our Investment Bank account.
Some Python developers argue it is not necessary use a main function. It is beyond the scope of this article. Most of developers use and I prefer do the same. So, here it is:
 
As you can see, the first object is oaHeader that calls oaConn(). 
 
It is a simple code. Just get the parameters stored in a flat file oauth.ini. In my case I used Ally as the Investment Bank account, but you can customize to get data from any other Banks. You will need to see if they use OAuth as their authentication method and how can you get the four parameters: client_key, client_secret, resource_owner_key and resource_owner_secret. At least in my experience with Ally, I needed to ask these data using an internal Form. This is a personal information that will give access to your account and, therefore, get data you will need in this program. A good introductory article how OAuth works you can find here.
headeroauth is the object used to connect to the Bank account from now on.
You can see below the parser will get four parameters from oauth.ini. In my Git you will find a sample file with the variables, but, naturally, with no tokens.
 
Now we have the object to use to connect and gather Stock and Option data from our Investment Account. Below you will find the code to use this object, get Bank Data and store it in PostgreSQL.
 
The qry variable store all Symbols you want to get from your Bank. I put some stocks as sample, but you can select any others. The token_url will vary for each Bank and, even in Ally, there are different URL used for different purposes. In future versions of this code, I will add this variable in oauth.ini to get more flexibility and to keep Python code clean.
 
getBankData uses the headeroauth object and token_url to request data from Investment Bank. Returned data (r) will store the results in JSON format. We need to use JSON module to deserialize returned it. I extracted just the data I would need to get the values to store in PostgreSQL.
The next part of the code is really an amazing Python feature. I used an iterator to open, insert rows, and close PostgreSQL connection. To whom is familiar with Databases (like I am), iterators are like sequences and work as cursors. Because you can associate a “start” and “end” code, you can keep your PostgreSQL connection opened just during the data load process. As you can see, try is the executed when newStock is first called and returns PostgreSQL cursor. When there are no more rows, it will execute finally code that will commit and close the connection.
 
You can see that the for loop inside the with newStock will insert any given Symbols returned from getBankData. And because in psycopg2 they say there is no advantage in using executemany instead of execute, I decided (again) keep Python code as simple as possible. A good tutorial for psycopg2 can be found here.
To get Option data I basically replicate the code above, but now calling newStock with option as parameter just to show what was stored. The code is basically the same, with other columns names since, despite the Investment Bank query and JSON URL are the same, we need different data to analyze Options. You can see that the Options’ Symbols are different from Stocks’ ones.
 
Before I go
I created some other functions to address minor needs. One of them is the isNumber. I needed to create this one because json.loads returned every single data as string and none of Python standard methods returned numbers to be stored in PostgreSQL.

The dbValues function was created to create a list of values to send to PostgreSQL to be replaced in INSERT … VALUES argument. It simply tests if data is numeric or not. If it is not numeric it will keep apostrophe and if numeric will get rid of it.
 
dbConfig, similarly of oaConfig, will get from database.ini PostgreSQL parameters (database, login, and password) to be used in this program. I hard coded PostgreSQL, but you can set this up to any other database you want to use.
 
Thanks for reading!
