import datajoint as dj

# Define the subject management schema
schema = dj.Schema("subject_management")

@schema
class Subject(dj.Manual):
    definition = """
    subject_id : int
    ---
    subject_name : varchar(50)
    species : varchar(50)
    """
