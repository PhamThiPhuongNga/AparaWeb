from django import forms
from .models import Comment 
class CommentForm (forms.ModelsForm):
    def __init__(self, *args, **kwargs):
        self.author = kwargs.pop('author', None)
        self.location = kwargs.pop('location', None)
        super().__init__(*args, **kwargs)
    def save(self, commit=True):
        comment = super().save(commit=False)
        comment.author = self.author
        comment.location = self.location
        comment.save()
    class Meta:
        model = Comment
        fields = ["body"]