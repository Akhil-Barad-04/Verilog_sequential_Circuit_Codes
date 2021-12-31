module sr_latch(s,r,en,q,qb);

    output q,qb;
    input s,r,en;
    wire sb,rb;

    nand G1(sb,s,en);
    nand G2(rb,r,en);
    nand G3(q,sb,qb);
    nand G4(qb,rb,q);

endmodule