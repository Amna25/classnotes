import pdb 
from models.task import Task
import repositories.task_repository as task_repository  

task_1=Task("Learn Python", "Cohort E54", 5)
task_repository.save(task_1)

result = task_repository.select_all()

for task in result:
    print(task.__dict__)

pdb.set_trace()