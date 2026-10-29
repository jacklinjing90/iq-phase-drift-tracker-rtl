"""Standalone Python model check; does not simulate Verilog RTL."""
def discriminator(samples,shift=3):
    prev=None;smooth=0;out=[]
    for i,q in samples:
        if prev is not None:
            metric=prev[0]*q-prev[1]*i
            smooth+=(metric-smooth)>>shift
            out.append((metric,smooth))
        prev=i,q
    return out

def run():
    r=discriminator([(100,0),(0,100),(-100,0),(0,-100)])
    assert [m for m,_ in r]==[10000]*3 and r[-1][1]>0
    print('PASS: Python phase-drift reference')

if __name__=='__main__':run()
