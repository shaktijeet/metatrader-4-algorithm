//+------------------------------------------------------------------+
//|                                                       moveon.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
extern int TakeProfit = 50;
extern int StopLoss = 25;


extern bool UseMoveToBreakeven= true;
extern int WhenToMoveBe = 100;
extern int PipsToLockIn = 5;

extern int FastMA=5;
extern int FastMaShift= 0;
 extern int FastMaMethod = 0;
 extern int FastMaAppliedTo = 0;
extern int SlowMA=21;
extern int SlowMaShift= 0;
 extern int SlowMaMethod = 0;
 extern int SlowMaAppliedTo = 0;
extern double LotSize = 0.01;
extern int MagicNumber = 1234;
double pips;


int init()
 {

     double ticksize = MarketInfo(Symbol(), MODE_TICKSIZE);
     if(ticksize == 0.00001 || ticksize == 0.001)
     pips = ticksize*10;
     else pips = ticksize;
  
  return (0);
  }
int deinit()
{


return (0);
}

int start()
{
if(UseMoveToBreakeven) MoveToBreakeven();
  if(IsNewCandle())CheckForTrade();
  
  
  return (0);
}

void  MoveToBreakeven()
{

for(int b=OrdersTotal()-1; b>=0; b--)
  {

if(OrderSelect(b,SELECT_BY_POS,MODE_TRADES))
  if(OrderMagicNumber() ==MagicNumber)
      if(OrderType()== OP_BUY)
         if(Bid-OrderOpenPrice()>WhenToMoveBe*pips)
            if(OrderOpenPrice()>OrderStopLoss())
               OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice() + (PipsToLockIn*pips),OrderTakeProfit(),0,CLR_NONE );
   
   }
for(int s=OrdersTotal()-1; s>=0; s--)
  {

if(OrderSelect(s,SELECT_BY_POS,MODE_TRADES))
  if(OrderMagicNumber() ==MagicNumber)
      if(OrderType()== OP_SELL)
         if(OrderOpenPrice()-Ask>WhenToMoveBe*pips)
            if(OrderOpenPrice()<OrderStopLoss())
               OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice() -(PipsToLockIn*pips),OrderTakeProfit(),0,CLR_NONE );
   
   }

}
 bool IsNewCandle()
 {
 static  int  BarsOnChart=1234;
   if(Bars == BarsOnChart)
 
 //in the array 
    
    return (false);
    
    BarsOnChart = Bars;
   
 return (true);
 
 
 }
void CheckForTrade()
{
double PreviousFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,2);

double CurrentFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,1);



double PreviousSlow = iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,2);

double CurrentSlow =     iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,1);

if( PreviousFast<PreviousSlow && CurrentFast>CurrentSlow)OrderEntry(0);
if( PreviousFast>PreviousSlow && CurrentFast<CurrentSlow)OrderEntry(1);

}



void OrderEntry(int direction)
{

if(direction == 0)
     if(OrdersTotal()==0)
     if(OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,Ask-(StopLoss*pips),Ask+(TakeProfit*pips),NULL,MagicNumber,0,Green)==true)
     Print("Buying take Place");

if(direction==1)
  if(OrdersTotal()==0) 
  if(OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,Bid+(StopLoss*pips),Bid-(TakeProfit*pips),NULL,MagicNumber,0,Red)==true)
  Print("Selling take Place");
}  