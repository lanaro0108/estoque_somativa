p = r'C:\Projetos\Escola\petshop_somativa\lib\screens\produto_detail_screen.dart'
with open(p,'rb') as f:
    for i, line in enumerate(f, start=1):
        if i>12:
            break
        print(i, line)
