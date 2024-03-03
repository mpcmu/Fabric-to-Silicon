import os
import re

rfile = open('rr.xml', 'r')
wfile = open('rr_fasm.xml', 'w')

flag = 0
for line in rfile:
        if 'rr_edges' in line:
                flag = 1 - flag
                wfile.write(line)
        elif flag == 1:
                ids = re.findall(r'\d+', line)
                tabs = line.count('\t')
                tabs = '\t' * tabs
                if ids[2] != '0':
                    wfile.write('{3}<edge sink_node="{0}" src_node="{1}" switch_id="{2}">\n'.format(ids[0], ids[1], ids[2], tabs))
                    wfile.write('{0}<metadata>\n'.format(tabs+'\t'))
                    wfile.write('{0}<meta name="fasm_features">sink_{1}_src_{2}</meta>\n'.format(tabs+'\t\t', ids[0], ids[1]))
                    wfile.write('{0}</metadata>\n'.format(tabs+'\t'))
                    wfile.write('{0}</edge>\n'.format(tabs))
                else:
                    wfile.write(line)
        else:
                wfile.write(line)
rfile.close()
wfile.close()
#os.replace('rr_new.xml', 'rr.xml')
