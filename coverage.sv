//coverage
class dram_cov extends uvm_subscriber#(dram_seq_item);

  `uvm_component_utils(dram_cov)
  uvm_analysis_imp#(dram_seq_item, dram_cov) item_got_export1;

  dram_seq_item tr;

covergroup cg_in;
   option.per_instance= 1;
    option.name        = "functional_cov";
  option.auto_bin_max=20;
  DATA : coverpoint tr.data_in {
      bins din[] = {[0:255]};
    }
    ADDRESS:coverpoint tr.add{
      bins addr[] = {[0:64]};
    }
  enable: coverpoint tr.en;
  write: coverpoint tr.wr;
  

//   r:coverpoint tr.r;
 // sxr: cross s,r;

endgroup
  
 covergroup cg_out;
//     option.per_instance= 1;
//     option.comment     = "coverage";
    option.name        = "functional_cov";
   option.auto_bin_max=20;

  D_OUT:coverpoint tr.data_out{
      bins addr[] = {[0:32]};
    }

//   qbar: coverpoint tr.qbar;


 endgroup

 

function new(string name="dram_cov",uvm_component parent);

  super.new(name,parent);

  item_got_export1= new("item_got_export1", this);

  tr=dram_seq_item::type_id::create("tr");

  cg_in=new();
  
  cg_out=new();

endfunction

 

  function void write(dram_seq_item t);

   tr=t;

   cg_in.sample();

    $display("input coverage =%0d ",cg_in.get_coverage());
     cg_out.sample();

    $display("output coverage =%0d ",cg_out.get_coverage());

endfunction

endclass