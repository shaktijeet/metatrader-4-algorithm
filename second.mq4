//+------------------------------------------------------------------+
//| Import MySQL functions, varriables                               |
//+------------------------------------------------------------------+

#import "libmysql.dll"
   int mysql_init(int db);
   int mysql_errno(int TMYSQL);
   int mysql_real_connect(int TMYSQL, string host, string user, string password, 
                          string db,int port,int socket,int clientflag);
   int mysql_real_query(int TMSQL, string query, int length);
   void mysql_close(int TMSQL);
#import

   int mysql;
   string host = "127.0.0.1";
   string user = "root";
   string password = "";
   string db = "mt4";
   int port = 3306;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
//---
   mysql = mysql_init(mysql);
   if(mysql != 0)
      Print("MySQL Allocated!");
   int res = mysql_real_connect(mysql,host,user,password,db,port,NULL,0);
   int err = GetLastError();
   if(res == mysql) 
      Print("MySQL Connected!");
   else 
      Print("Connect Error: ", mysql, " ", mysql_errno(mysql), " ");
//---
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
//---
   mysql_close(mysql);
   return;
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
//---
   int length = 0;
   string query = StringConcatenate("CREATE TABLE trade (id int not null primary key auto_increment, currency varchar(20), timeframe varchar(20), price double, sl double, tp double);");
   Print (query);
   length = StringLen(query);
   mysql_real_query(mysql, query, length);
   int myerr = mysql_errno(mysql);
   if(myerr > 0)
      Print("Create Error: ",myerr);
   else
      Print("MySQL Table Created!");
   
//----
 }