from django import forms
from .models import Comment 
class CommentForm (forms.ModelForm):
    def __init__(self, *args, **kwargs):
        self.author = kwargs.pop('author', None)
        self.detaillocation = kwargs.pop('detaillocation', None)
        # self.rating = kwargs.pop('rating', None)
        super().__init__(*args, **kwargs)
    def save(self, commit=True):
        comment = super().save(commit=False)
        comment.author = self.author
        comment.detaillocation = self.detaillocation
        # comment.rating = self.rating
        comment.save()
    class Meta:
        model = Comment
        # fields = ["body"]
        fields = ('rating','body')
        labels={'rating':'Rating'}
        widgets={
            'rating':forms.TextInput(attrs={'type':'range','step':'1','min':'1','max':'5','class':{'custom-range','border-0'}})
        }