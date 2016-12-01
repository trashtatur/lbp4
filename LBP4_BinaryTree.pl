% 1.is_sbin_tree(Tree) 
%welches überprüft, ob Tree von obiger syntaktischer Form ist und ob die Semantik, also die Sortierung, korrekt ist.

is_sbin_tree(nil).  %Fall des leeren Baumes, da dies auch ein Baum ist per der Definition.
is_sbin_tree(t(Element,LeftTree,RightTree)) :- integer(Element),
											   bigger(Element,LeftTree),smaller(Element,RightTree),
											   is_sbin_tree(LeftTree), 
											   is_sbin_tree(RightTree). %Geht die Unterzweige rekursiv durch
											   
%1.1 Hilfsprädikate:

smaller(_Elem,nil).
smaller(Elem, t(OtherElem,LeftTree,RightTree)) :- Elem < OtherElem, smaller(Elem,LeftTree), smaller(Elem,RightTree).

bigger(_Elem, nil).
bigger(Elem, t(OtherElem,LeftTree,RightTree)) :- Elem > OtherElem, bigger(Elem,LeftTree), bigger(Elem,RightTree).
											   
%TODO Semantische Prüfung fehlt

%2 insert_sbin_tree(Element,Tree,NewTree)
%welches Element in den sortierten Binärbaum Tree einfügt 
%resultierend im neuen sortierten Binärbaum NewTree
%Fügt an Blatt ein. Also dort wo kein Sucessor ist.

insert_sbin_tree(Element,nil,t(Element,nil,nil)).
insert_sbin_tree(NewElem,t(Elem,LeftTree,RightTree),t(Elem,OLeftTree,ORightTree)):- (NewElem < Elem,insert_sbin_tree(NewElem,LeftTree,OLeftTree)),!;
										(NewElem >= Elem,insert_sbin_tree(NewElem,RightTree,ORightTree)). 										 

%3 inorder_sbin2tree(Tree, List) 
%welches den sortierten Binärbaum Tree 
%in Inorder-Reihenfolge traversiert und die Elemente in die Liste List schreibt



%4 list2sbin_tree(List, Tree) 
%welches eine sortierte Liste List ganzer Zahlen in einen 
%sortierten Binärbaum von obiger Gestalt transformiert. Versuchen Sie den Baum möglichst balanciert aufzubauen



%4.1 schreiben Sie sich dazu das Prädikat halfList(List,FirstPart,SecondPart)  
%das eine Liste in zwei gleich große 
%Listen aufteilt. Der head von SecondPart wäre dann die Wurzel dieses Baums. Bei ungerader Anzahl an Elementen ist SecondPart 
%die größere Liste.



%5 Implementieren Sie als nützliches Hilfsprädikat das Prädikat gennumslist(Anzahl,List), 
%um eine sortierte Liste zufälliger ganzer Zahlen mit Anzahl Elementen zu generieren, ggf. mit Hilfe des Prolog-Prädikates sort/2.



