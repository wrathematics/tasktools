suppressMessages(library(pbdMPI))
suppressMessages(library(tasktools))

costly = function(x, waittime)
{
  Sys.sleep(waittime)
  cat(paste("iter", x, "executed on rank", comm.rank(), "\n"))
  
  sqrt(x)
}

ret = mpi_napply(10, costly, checkpoint_path="/tmp", preschedule=FALSE, waittime=0.5)
comm.cat("\n", quiet=TRUE)
comm.print(unlist(ret))

finalize()
