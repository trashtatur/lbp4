% 1.is_sbin_tree(Tree) 
%welches Ã¼berprÃ¼ft, ob Tree von obiger syntaktischer Form ist und ob die Semantik, also die Sortierung, korrekt ist.

is_sbin_tree(nil).  %Fall des leeren Baumes, da dies auch ein Baum ist per der Definition.
is_sbin_tree(t(Element,LeftTree,RightTree)) :- integer(Element),                    %Typpruefung des betrachteten Elements, ist es ein Integer?
                                               biggerEquals(Element,LeftTree),  %Das Element muss groesser oder gleich aller Werte im linken Teilbaum sein. Diese Pruefung wird vom Hilfspraedikat biggerEquals durchgefuehrt.
                                               smaller(Element,RightTree),              %Das Element muss kleiner aller Werte im rechten Teilbaum sein. Diese Pruefung wird vom Hilfspraedikat smaller durchgefuehrt.
                                               is_sbin_tree(LeftTree), 
                                               is_sbin_tree(RightTree).                 %Geht die unteren Teilbaeume rekursiv ab.
                                                                                           
%1.1 HilfsprÃ¤dikate:
%Prüfen die unteren Teilbäume jeweils auf syntaktische Korrektheit durch. Arbeiten rekursiv um den gesamten Teilbaum abzudecken

smaller(_Elem,nil).                                                                                     %Ist der zu pruefende Baum nil so endet die Pruefung.
smaller(Elem, t(OtherElem,LeftTree,RightTree)) :- Elem < OtherElem,                                     %Element muss kleiner als das andere Element im Root des Teilbaums sein
                                                  smaller(Elem,LeftTree),                               %Pruefung wird rekursiv mit dem Wert für den inneren linken Teilbaum des übergebenen Teilbaumes durchgefuehrt
                                                  smaller(Elem,RightTree).                              %Pruefung wird rekursiv mit dem Wert für den inneren linken Teilbaum des übergebenen Teilbaumes durchgefuehrt

biggerEquals(_Elem, nil).                                                               %Ist der zu pruefende Baum nil so endet die Pruefung.
biggerEquals(Elem, t(OtherElem,LeftTree,RightTree)) :- Elem >= OtherElem,               %Element muss größer oder gleich dem anderen Element im Root des Teilbaums sein
                                                       biggerEquals(Elem,LeftTree),     %Pruefung wird rekursiv mit dem Wert für den inneren linken Teilbaum des übergebenen Teilbaumes durchgefuehrt
                                                       biggerEquals(Elem,RightTree).    %Pruefung wird rekursiv mit dem Wert für den inneren linken Teilbaum des übergebenen Teilbaumes durchgefuehrt
                                                                                           

%2 insert_sbin_tree(Element,Tree,NewTree)
%welches Element in den sortierten BinÃ¤rbaum Tree einfuegt 
%resultierend im neuen sortierten BinÃ¤rbaum NewTree


insert_sbin_tree(NewElem,nil,t(NewElem,nil,nil)).         %Ist der uebergebene Baum oder bzw. Teilbaum leer, so wird ein neuer Baum erstellt, der NewElem als Root hat.
insert_sbin_tree(NewElem,t(Elem,LeftTree,RightTree),t(Elem,NewLeftTree,NewRightTree)):- (NewElem < Elem,insert_sbin_tree(NewElem,LeftTree,NewLeftTree)),!;
                                                                                        (NewElem >= Elem,insert_sbin_tree(NewElem,RightTree,NewRightTree)).

%3 inorder_sbin2tree(Tree, List) 
%welches den sortierten Binaerbaum Tree 
%in Inorder-Reihenfolge traversiert und die Elemente in die Liste List schreibt

%Fall des leeren Baumes, ergibt auch eine leere Liste und beendet das Programm.
inorder_sbin2tree(nil, []).                     %Bei einem leeren Baum gibt es eine leere Liste.
inorder_sbin2tree(t(Root, Left, Right), List) :-inorder_sbin2tree(Left, LList),         %Erst wird der linke Baum abgearbeitet,
                                                                                        inorder_sbin2tree(Right, RList),        %Dann der rechte Baum
                                                                                        append([LList,[Root],RList],List).      

%4 list2sbin_tree(List, Tree) 
%welches eine sortierte Liste List ganzer Zahlen in einen 
%sortierten Binaerbaum von obiger Gestalt transformiert. Versuchen Sie den Baum moeglichst balanciert aufzubauen
list2sbin_tree([],nil).
list2sbin_tree(List,t(Element,LeftTree,RightTree)):- halfList(List,LeftList,[Element|RightList]),
                                                     list2sbin_tree(LeftList,LeftTree),
                                                     list2sbin_tree(RightList,RightTree).
                                                                                                         
%4.1 schreiben Sie sich dazu das Praedikat halfList(List,FirstPart,SecondPart)  
%das eine Liste in zwei gleich grosse 
%Listen aufteilt. Der head von SecondPart waere dann die Wurzel dieses Baums. Bei ungerader Anzahl an Elementen ist SecondPart 
%die groessere Liste.

%halflist([],[],[]).            %Fall der leeren Liste, in dem Fall wird auch eine leere Liste zurückgegeben.
%halflist(SourceListe,LeftList,RightList):- length(SourceList,LengthSource), Mitte is round((LengthSource-1)/2),

halfList(SourceList, LeftList, RightList) :- append(LeftList, RightList, SourceList),           %SourceList ist hier die Quelle, append liefert hier also die Aufteilung.
                                             length(LeftList, Length),                          %Ueber length findet man die Laenge der Listen, da wir die selbe Variable nutzen
                                             length(RightList, Length).                         %definieren wir append, dass beide Listen auch gleich lang sein muessen.
                                                                                                %Sollten beide Listen nicht gleich lang sein, dann geht das Praedikat in den anderen Fall.
                                                                                                                                                                                        
halfList(SourceList, LeftList, RightList) :- append(LeftList, RightList, SourceList),           %SourceList ist hier die Quelle, append liefert hier also die Aufteilung. (wie oben)
                                             length(LeftList, Length),                          %Ueber length definiert man append, wie lang die einzelnen Listen sein duerfen.
                                             LengthPlusOne is Length + 1,                       %Da das hier der Fall fuer die ungerade Liste ist, muss auf Length +1 addiert werden.
                                             length(RightList, LengthPlusOne).                  %Die zweite Liste ist dann also um eins laenger um den Head in sich zu tragen fuer den Tree

%5 Implementieren Sie als nuetzliches HilfsprÃ¤dikat das Praedikat gennumslist(Anzahl,List), 
%um eine sortierte Liste zufaelliger ganzer Zahlen mit Anzahl Elementen zu generieren, ggf. mit Hilfe des Prolog-Praedikates sort/2.

gennumslist(Anzahl,List):- Range is Anzahl*50,                  %Die Range definiert den Bereich, aus dem die Zahlen stammen duerfen. Hier wird dafuer ein Multiplikator definiert, der
                                                                %aussagt, dass die uebergebene Anzahl mit 50 multipliziert, den Bereich angibt mit dem randset eine Liste erzeugen soll.
                           randset(Anzahl,Range,List).          %Da Randset bereits eine sortierte Liste liefert, ist es nicht noetig auf dieser noch so etwas wie sort/2 aufzurufen.
