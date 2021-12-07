from db.run_sql import run_sql

from models.task import Task
  
def select_all():  
    tasks = [] 

    sql = "SELECT * FROM tasks"
    results = run_sql(sql)

    for row in results:
        task = Task(row['description'], row['assignee'], row['duration'], row['completed'], row['id'] )
        tasks.append(task)
    return tasks 

def save(task):
        sql="INSERT INTO task(description, assign,duration,completed)  VALUES(%s, %s, %s, %s)"
        values=[task.description, task.assignee, task.duration, task.completed]
        run_sql(sql, values) 

       