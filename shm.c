#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct shm_page {
    uint id;
    char *frame;
    int refcnt;
  } shm_pages[64];
} shm_table;

void shminit() {
  int i;
  initlock(&(shm_table.lock), "SHM lock");
  acquire(&(shm_table.lock));
  for (i = 0; i< 64; i++) {
    shm_table.shm_pages[i].id =0;
    shm_table.shm_pages[i].frame =0;
    shm_table.shm_pages[i].refcnt =0;
  }
  release(&(shm_table.lock));
}

//cs153
int shm_open(int id, char **pointer) {
  int i;
  struct proc *curproc = myproc(); 
  int idExists = 0;
  int tableIndex = 0;
 // char* pageAddr = 0;
  //cprintf(pageAddr);
  //checks if the id already exists in shm_table

  acquire(&(shm_table.lock));
  for (i = 0; i< 64; i++) {
    //acquire(&(shm_table.lock));
    if(shm_table.shm_pages[i].id == id) { //id exists
      //release(&(shm_table.lock));
      cprintf("id exists in page table!\n"); 
      idExists = 1;
      //pageAddr == the physical address of the page in the table
      //pageAddr = shm_table.shm_pages[i].frame;
      tableIndex = i;
      break;
    }
    //release(&(shm_table.lock));
  }
  
  //Case 1: id exists
  if (idExists){
    cprintf("ID EXISTS!\n");
    
    //takes physical address of page in the table and maps it to an available page in our va space
    // mappages(curproc->pgdir, (void *)PGROUNDUP(curproc->sz), PGSIZE, V2P(pageAddr), PTE_W|PTE_U);
    // mappages(curproc->pgdir, (void *)PGROUNDUP(KERNBASE - 4), PGSIZE, V2P(pageAddr), PTE_W|PTE_U);
    //acquire(&(shm_table.lock));
    //mappages(curproc->pgdir, (void *)PGROUNDUP(KERNBASE - 4), PGSIZE, V2P(shm_table.shm_pages[tableIndex].frame), PTE_W|PTE_U); 
    mappages(curproc->pgdir, (void *)PGROUNDUP(curproc->sz), PGSIZE, V2P(shm_table.shm_pages[tableIndex].frame), PTE_W|PTE_U); 

    //increase refcnt by 1
    shm_table.shm_pages[tableIndex].refcnt++;
   // release(&(shm_table.lock));
   //TODO switch these? 
    *pointer = (char *)PGROUNDUP(curproc->sz); 
    curproc->sz =+ PGSIZE; //not sure???
    //return (int)pointer;
    release(&(shm_table.lock));
    return 0;
  }

  //Case 2: id does NOT exist
  else{ 
    cprintf("ID does not exist\n"); 
    
    for (i = 0; i< 64; i++) {
      cprintf("begin of loop\n"); 
     // acquire(&(shm_table.lock));
      if(shm_table.shm_pages[i].refcnt == 0) { //if an empty table entry 
        cprintf("refcnt == 0\n"); 
          //initialize empty entry in the shm_table id to the id passed to us
	  shm_table.shm_pages[i].id = id;
          shm_table.shm_pages[i].frame = kalloc();
          
          memset(shm_table.shm_pages[i].frame, 0, PGSIZE);
          cprintf("calling mappages\n");
    	  //if(mappages(curproc->pgdir, (void *)PGROUNDUP(KERNBASE - 4), PGSIZE, V2P(shm_table.shm_pages[i].frame), PTE_W|PTE_U) < 0){
    	  if(mappages(curproc->pgdir, (void *)PGROUNDUP(curproc->sz), PGSIZE, V2P(shm_table.shm_pages[i].frame), PTE_W|PTE_U) < 0){
      	    cprintf("allocuvm out of memory (2)\n");
      	    deallocuvm(curproc->pgdir, 0, curproc->sz);
      	    kfree(shm_table.shm_pages[i].frame);
            release(&(shm_table.lock));
      	    return 0;
    	  } 
	  else {
            cprintf("finished with mappages\n");
            release(&(shm_table.lock));
            //curproc->sz += PGSIZE;
            *pointer = (char *)PGROUNDUP(curproc->sz);
             cprintf("page has updated!\n");
	     return 0;
          }
          //release(&(shm_table.lock));
        
        }
      }
//        cprintf("return1");
//        release(&(shm_table.lock));
//        return 0;
//     }
     }       
  cprintf("return2");
  release(&(shm_table.lock));
  return 0;
}
      /*if(shm_table.shm_pages[i].refcnt == 0) { //if an empty table entry 
          mem = kalloc();
          //initialize empty entry in the shm_table id to the id passed to us
          shm_table.shm_pages[i].id = id;
          shm_table.shm_pages[i].frame = mem;
          memset(mem, 0, PGSIZE);
          mappages(curproc->pgdir, (void *)PGROUNDUP(KERNBASE - 4), PGSIZE, V2P(shm_table.shm_pages[i].frame), PTE_W|PTE_U); 
         
          curproc->sz += PGSIZE;
          *pointer = (char *)PGROUNDUP(curproc->sz);
          return 0;
         break;*/
        
      /*if(shm_table.shm_pages[i].refcnt == 0) { //if an empty table entry 
        a = PGROUNDUP(KERNBASE - 4);
        for(; a > 0; a -= PGSIZE){
    	  mem = kalloc();
    	  if(mem == 0){
      	    cprintf("allocuvm out of memory\n");
      	    deallocuvm(curproc->pgdir, 0, KERNBASE - 4);
      	    return 0;
          }
          //initialize empty entry in the shm_table id to the id passed to us
	  shm_table.shm_pages[i].id = id;
          shm_table.shm_pages[i].frame = mem;
          memset(mem, 0, PGSIZE);
    	  if(mappages(curproc->pgdir, (void *)PGROUNDUP(KERNBASE - 4), PGSIZE, V2P(shm_table.shm_pages[i].frame), PTE_W|PTE_U) < 0){
      	    cprintf("allocuvm out of memory (2)\n");
      	    deallocuvm(curproc->pgdir, 0, KERNBASE - 4);
      	    kfree(mem);
      	    return 0;
    	  } 
	  else {
            curproc->sz += PGSIZE;
            *pointer = (char *)PGROUNDUP(curproc->sz);
          }
        }
      }
        return (int)pointer;
        break;
      }*/

	/*if(shm_table.shm_pages[i].refcnt == 0) { //if an empty table entry 
        //initialize empty entry in the shm_table id to the id passed to us
        shm_table.shm_pages[i].id = id;
        cprintf("Before kalloc\n");
        //empty entry will now have physical page
        shm_table.shm_pages[i].frame = kalloc();//not sure, professor mentioned kmalloc() 
        cprintf("After kalloc\n");
        pageAddr = shm_table.shm_pages[i].frame;
        memset(pageAddr, 0, PGSIZE);
        tableIndex = i;
        break;
      }*/
    //}
    
    //mappages(curproc->pgdir, (void *)PGROUNDUP(curproc->sz), PGSIZE, V2P(pageAddr), PTE_W|PTE_U);
    //mappages(curproc->pgdir, (void *)PGROUNDUP(KERNBASE - 4), PGSIZE, V2P(shm_table.shm_pages[tableIndex].frame), PTE_W|PTE_U); 
    //*pointer = KERNBASE - 4;

    //set refcnt to 1
    //shm_table.shm_pages[tableIndex].refcnt = 1;
    //release(&(shm_table.lock));
  //}
//return 0; //added to remove compiler warning -- you should decide what to return
//}


int shm_close(int id) {
  int i;
  acquire(&(shm_table.lock));
  for (i = 0; i< 64; i++) {
    if(shm_table.shm_pages[i].id == id) {
      if(shm_table.shm_pages[i].refcnt >= 1) {
        shm_table.shm_pages[i].refcnt--;
      }
      else { //refcnt == 0
        kfree(shm_table.shm_pages[i].frame);
      }
    }  
  }
  release(&(shm_table.lock));
return 0; //added to remove compiler warning -- you should decide what to return
}

//int
//kmalloc(pde_t *pgdir, uint oldsz, 
