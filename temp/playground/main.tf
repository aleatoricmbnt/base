# resource "null_resource" "name" {
#   triggers = {
#     long = var.string
#   }
# }

# variable "string" {
#   default = "*7%eL*C(Pl:9_8v*d3)uXc#0udb4QU]a$#58sJYzwz#!V:FHRqOW!rJUq}5q?F(ZDA9b)mtRz:9Z7FSo[x6J_qfw4}*{cUm@9q_rU)9ChkVq]VtSZ_WvZKNCI&RxnY@?bB{y@1%SJ_Ed@}4avR!Rx$!HcZ1&2l=O%XK#7iLmKXd3cwcv_K&9kGBcH0a<+Szf4s9(*(5VhvSHw@Pd)y6nE]3#&dTA![FoG2b25KgT1YlXfRK]xzg=FxEW30R}l(N2*vGcg#_7(L(-Rzxtzl[9nByrNX4m2>mddsDY7]20=FHF0WIG-bC:GyL1[993(2PTq]T!GrwxW@Ryp(J(}5x+gZLY2{uhI{e]MjzaYsD]DnZE1#6b88OX?r3>Bg(Sy<<=CmU?]$aX1$YnCfj3sROt5X]Y{x?dj$:C1!n1GmcHXD8}kzY#GAqYqBQ]i-Q*yjpITQVKm{0&T-[)zmjjJNSl<1LjLQKsBdvSu_=TPx%rbEpQ63Ab&PLTYBjv5Ws!Mx}*V5uO5&68()2EKv2v@A%gal?8>$NFK313KiOqc_4{j2w?UZmiEDJj8VZNeXASX$RzPDn$<@-T@c05]f_#3:yM@(DZ1<!lC*y?*o(r*rt4L#<4}2=-GpVvgb+Q7GK>&Y)6AAsoToF!h#C]4G7YrMcnEWcv&$2=):?Ntckc@@CTZ*xu2{CQ+b$iGF${<ORXlr>*ra##<{{}!Ec7jR>F8y>7PE!+1D<p(kol({(lfxu[2V[0L5Zp2Wdm2c-VxpuI!zlERa$?-0AqAnv-fN&=mkbIIa{*d{5&%QE:J%&yvO}P0UsX1ID9VTsL$:{$Ps[F!7#80#N+hc4%?uM1TR3l1Gtu@<2j4(:+!HTl<n56q%Iz$#+#mMofr01Y6!k22tQ6f>o))(:{<@SB-F}9WLC5}P*s?+EVD_a8SX9y8j]weaD)buX?ye:d$=?{Sf+dYjm3fpe!w]F60?$Yge6(-wU2>g63rxL({LTH}!G}cQv*&SV-"
# }

resource "random_string" "name" {
  length = 1000
