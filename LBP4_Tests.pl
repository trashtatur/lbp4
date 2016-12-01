% Autor:
% Datum: 30.07.2015

test(is_sbin_tree) :-
    %positiv
    write('is_sbin_tree +'),
    is_sbin_tree(nil), write('.'),!,
    is_sbin_tree(t(111, nil, nil)), write('.'),!,
    is_sbin_tree(t(586, t(199, t(128, t(111, nil, nil), t(137, nil, nil)), t(450, t(408, nil, nil), nil)), t(719, t(656, t(645, nil, nil), t(690, nil, nil)), t(940, t(919, nil, nil), nil)))), write('.'),!,
    is_sbin_tree(t(586, t(199, t(128, t(111, nil, nil), t(137, nil, nil)), t(450, t(408, nil, nil), nil)), t(719, t(656, t(645, nil, nil), t(690, nil, nil)), t(940, t(919, nil, nil), nil)))), write('.'),!,
    gennumslist(10000,UList),list2sbin_tree(UList,Tree), write('*'),!,is_sbin_tree(Tree),
    %negativ
    write('. -'),!,
    \+ is_sbin_tree(t(keinBaum, nil)), write('.'),!,
    \+ is_sbin_tree(t(505, t(448, t(282, nil, nil), t(582, nil, nil)), t(969, t(456, nil, nil), t(980, nil, nil)))), write('.'),!,
    \+ is_sbin_tree(t(keineZahl, nil, nil)),!, writeln('ok').

test(insert_sbin_tree) :-
    write('insert_sbin_tree '),
    insert_sbin_tree(42,t(138, t(5, t(2, nil, nil), t(98, nil, nil)), t(234, t(215, nil, nil), t(279, nil, nil))),
                        t(138, t(5, t(2, nil, nil), t(98, t(42, nil, nil), nil)), t(234, t(215, nil, nil), t(279, nil, nil)))), write('.'),!,
    insert_sbin_tree(42,nil,t(42, nil, nil)),!, writeln('ok').

test(inorder_sbin2tree) :-
    write('inorder_sbin2tree '),
    inorder_sbin2tree(nil,[]), write('.'),!,
    inorder_sbin2tree(t(138, t(5, t(2, nil, nil), t(98, t(42, nil, nil), nil)), t(234, t(215, nil, nil), t(279, nil, nil))),
                      [2, 5, 42, 98, 138, 215, 234, 279]),!, writeln('ok').
    
test(list2sbin_tree) :-
    write('list2sbin_tree '),
    list2sbin_tree([2, 5, 42, 98, 138, 215, 234, 279],
                   t(138, t(42, t(5, t(2, nil, nil), nil), t(98, nil, nil)), t(234, t(215, nil, nil), t(279, nil, nil)))), write('.'),!,
    list2sbin_tree([],nil),!, writeln('ok').

test(halfList) :-
    write('halfList +'),
    halfList([],[],[]), write('.'),!,
    halfList([1,2,3,4,5,6,7],[1, 2, 3],[4, 5, 6, 7]), write('.'),!,
    halfList([1,2,3,4,5,6,7,8],[1, 2, 3, 4],[5, 6, 7, 8]),!, writeln('ok').

test(gennumslist) :-
    write('gennumslist '),
    gennumslist(42,List), write('.'),!,
    sort(List,List), write('.'),!,
    length(List,42),!, writeln('ok').


test(is_atomic_expr) :-
    %positiv
    write('is_atomic_expr +'),
    is_atomic_expr(_X), write('.'),!,
    %negativ
    write('. -'),!,
    \+ is_atomic_expr(x),!, writeln('ok').

test(is_literal) :-
    %positiv
    write('is_literal +'),
    is_literal(_X), write('.'),!,
    is_literal(mnot(_Y)), write('.'),!,
    %negativ
    write('. -'),!,
    \+ is_literal(x), write('.'),!,
    \+ is_literal(mnot(y)),!, writeln('ok').

test(is_clause) :-
    %positiv
    write('is_clause +'),
    is_clause(_X), write('.'),!,
    is_clause(or(_A,or(_B,or(or(mnot(_C),or(_D,_E)),_F)))), write('.'),!,
    %negativ
    write('. -'),!,
    \+ is_clause(impl(_G,_H)), write('.'),!,
    \+ is_clause(mnot(and(_I,_J))), write('.'),!,
    \+ is_clause(x), write('.'),!,
    \+ is_clause(mnot(and(or(_K,_L),_M))), write('.'),!,
    \+ is_clause(or(_N,or(_O,or(or(_P,or(q,r)),_S)))),!, writeln('ok').

test(is_horn_clause) :-
    %positiv
    write('is_horn_clause +'),
    is_horn_clause(_Z), write('.'),!,
    is_horn_clause(or(mnot(_A),or(_B,or(or(mnot(_C),or(mnot(_D),mnot(_E))),mnot(_F))))), write('.'),!,
    %negativ
    write('. -'),!,
    \+ is_horn_clause(impl(_G,_H)), write('.'),!,
    \+ is_horn_clause(mnot(and(_I,_J))), write('.'),!,
    \+ is_horn_clause(or(_T,or(_U,or(or(mnot(_V),or(_W,_X)),_Y)))), write('.'),!,
    \+ is_horn_clause(or(mnot(_A2),or(_B1,or(or(mnot(_C2),or(mnot(_D2),_E1)),mnot(_F2))))), write('.'),!,
    \+ is_horn_clause(x), write('.'),!,
    \+ is_horn_clause(mnot(and(or(_K,_L),_M))), write('.'),!,
    \+ is_horn_clause(or(_N,or(_O,or(or(_P,or(q,r)),_S)))),!, writeln('ok').

test(nnf_expr) :-
    write('nnf_expr '),
    nnf_expr(impl(and(and(mnot(and(E3,Z3)),impl(D3,Z3)),impl(and(Z3,mnot(E3)),mnot(D3))),mnot(D3)),
             or(or(or(and(E3, Z3), and(D3, mnot(Z3))), and(and(Z3, mnot(E3)), D3)), mnot(D3))), write('.'),!,
    nnf_expr(mnot(impl(and(and(mnot(and(E2,Z2)),impl(D2,Z2)),impl(and(Z2,mnot(E2)),mnot(D2))),mnot(D2))),
             and(and(and(or(mnot(E2), mnot(Z2)), or(mnot(D2), Z2)), or(or(mnot(Z2), E2), mnot(D2))), D2)), write('.'),!,
    nnf_expr(and(or(mnot(mnot(B)),A),or(and(mnot(A),mnot(and(B,mnot(C)))),and(A,and(B,mnot(C))))),
             and(or(B, A), or(and(mnot(A), or(mnot(B), C)), and(A, and(B, mnot(C)))))), write('.'),!,
    nnf_expr(X,X), write('.'),!,
    nnf_expr(or(A,or(B,or(or(mnot(C),or(D,E)),F))),
             or(A,or(B,or(or(mnot(C),or(D,E)),F)))), write('.'),!,
    nnf_expr(aequiv(and(xor(nand(E1,Z1),D1),Z1),nor(E1,Z1)),
             or(and(and(and(or(and(E1, Z1), mnot(D1)), or(or(mnot(E1), mnot(Z1)), D1)), Z1), and(mnot(E1), mnot(Z1))), and(or(or(and(or(mnot(E1), mnot(Z1)), D1), and(and(E1, Z1), mnot(D1))), mnot(Z1)), or(E1, Z1)))), write('.'),!,
    nnf_expr(mnot(X),mnot(X)),!, writeln('ok').


test(alltree) :-
    test(gennumslist),
    test(halfList),
    test(insert_sbin_tree),
    test(inorder_sbin2tree),
    test(list2sbin_tree),
    test(is_sbin_tree)
    .

test(allterm) :-
    test(is_atomic_expr),
    test(is_literal),
    test(nnf_expr),
    test(is_clause),
    test(is_horn_clause)
    .
